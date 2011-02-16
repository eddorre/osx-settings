require 'rubygems'

alias q exit

class Object
  def local_method
    (methods - Object.instance_methods).sort
  end
end

ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[1;30m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

# Get the Ruby Version from RVM
rvm_ruby = ENV['rvm_ruby_string'].to_s.gsub(/(^\w+\-(\d+\.?)+)/i).first || ''

# # Build a simple colorful IRB prompt
# IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
#   :PROMPT_I => "#{ANSI[:BLUE]}#{rvm_ruby}>>#{ANSI[:RESET]} ",
#   :PROMPT_N => "#{ANSI[:MAGENTA]}#{rvm_ruby}>>#{ANSI[:RESET]} ",
#   :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
#   :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
#   :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
#   :AUTO_INDENT => true }
# IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << "#{ANSI[:GREEN]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:GRAY]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []

# Wirble is a gem that handles coloring the IRB
# output and history
extend_console 'wirble' do
  Wirble.init
  Wirble.colorize
end

# awesome_print is prints prettier than pretty_print
extend_console 'ap' do
  alias pp ap
end

# When you're using Rails 2 console, show queries in the console
extend_console 'rails2', (ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')), false do
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# When you're using Rails 3 console, show queries in the console
extend_console 'rails3', defined?(ActiveSupport::Notifications), false do
  $odd_or_even_queries = false
  ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
    $odd_or_even_queries = !$odd_or_even_queries
    color = $odd_or_even_queries ? ANSI[:CYAN] : ANSI[:MAGENTA]
    event = ActiveSupport::Notifications::Event.new(*args)
    time  = "%.1fms" % event.duration
    name  = event.payload[:name]
    sql   = event.payload[:sql].gsub("\n", " ").squeeze(" ")
    puts "  #{ANSI[:UNDERLINE]}#{color}#{name} (#{time})#{ANSI[:RESET]}  #{sql}"
  end
end

extend_console 'interactive_editor' do
  # no configuration needed
end

# Show results of all extension-loading
puts "#{ANSI[:GRAY]}~> Console extensions:#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"