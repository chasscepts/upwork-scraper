class ArgsParser
  def initialize(default_value = 'present')
    @default = default_value
  end

  def parse(args)
    options = {}
    length = args.size
    index = 0
    int_pointer = 0
    while index < length
      arg = args[index]
      option = get_option(arg)
      index += 1

      if option.nil?
        options[int_pointer] = arg
        int_pointer += 1
      elsif index < length
        next_option = get_option(args[index])
        if next_option.nil?
          options[option] = args[index]
          index += 1
        else
          options[option] = @default
        end
      else
        options[option] = @default
      end
    end

    options
  end

  private

  def get_option(option)
    return nil unless option.is_a? String
    return option[2..-1] if option.start_with? '--'
    return option[1..-1] if option.start_with? '-'
  end
end