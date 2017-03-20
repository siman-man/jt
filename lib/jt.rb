require 'jt/version'
require 'json'
require 'colorize'

class Jt
  SPACE_SIZE = 8
  T_LINE = '├────'
  I_LINE = '│'
  L_LINE = '└────'

  def self.create(text)
    new(text)
  end

  def initialize(text)
    @queue = ["root\n".colorize(:red)]
    parse(JSON.parse(text))
  end

  def to_s
    @queue.join
  end

  private

  def parse(object, space = '')
    until object.empty?
      key, value = object.shift

      if key.instance_of?(Hash)
        @queue << get_line(end_line: object.empty?, space: space)
        @queue << "object\n".colorize(:red)
        parse(key, space + get_space(end_line: object.empty?))
        next
      end

      @queue << get_line(end_line: object.empty?, space: space)

      if value.instance_of?(Hash) && !value.empty?
        @queue << "#{key.inspect.colorize(:blue)}\n"
        parse(value, space + get_space(end_line: object.empty?))
      elsif value.instance_of?(Array) && !value.empty?
        @queue << "#{key.inspect.colorize(:blue)}\n"
        parse(value, space + get_space(end_line: object.empty?))
      else
        if object.instance_of?(Array)
          @queue << "#{output_value(key)}\n"
        else
          @queue << "#{key.inspect.colorize(:blue)}: #{output_value(value)}\n"
        end
      end
    end
  end

  def output_value(value)
    case value.class.to_s
      when /Hash/
        value.inspect
      when /Integer|Fixnum|Float|Bignum/
        value.inspect.colorize(:blue)
      when /TrueClass|FalseClass/
        value.inspect.colorize(:blue)
      else
        value.inspect.colorize(:green)
    end
  end

  def get_line(end_line: nil, space: '')
    end_line ? "#{space}#{L_LINE} " : "#{space}#{T_LINE} "
  end

  def get_space(end_line: nil)
    end_line ? ' ' * SPACE_SIZE : I_LINE + ' ' * (SPACE_SIZE-1)
  end
end
