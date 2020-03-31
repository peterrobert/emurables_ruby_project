module  Enumerable

  def my_each ( &parm )
    return to_enum :my_each unless block_given?
    item = self;
    i = 0
    while i < item.length
      if item.is_a?(Array)
        yield(item[i]) 
      elsif parm.arity == 1
        yield  ( assoc item.keys[i] ) 
      else
        yield item.keys[i] , item[item.keys[i]]
      end 
      i += 1
    end
  end

  def my_each_with_index 
    return to_enum :my_each unless block_given?
    item = self;
    i = 0
    while i < item.length

      if item.is_a?(Array)
 
        yield [i],item[i]

        i += 1
 
      elsif item.is_a?(Hash)
        yield [i],item.keys[i], item[item.keys[i]] 
        i += 1
      else
        yield(item)
      end 
    end
  end
  
  def my_select
    return to_enum :my_select unless block_given?
    items = self

    items = items.to_a if items.is_a? Range
    if items.is_a?(Array)

      new_values = Array.new

      items.my_each {|i| new_values.push(i) if yield(i) == true }

      return new_values

    elsif items.is_a?(Hash)

      new_values = Hash.new

      items.my_each {|a, b| new_values.store(a, b) if yield(a, b) == true}
      return new_values
    else
      return items
    end
  end

  def my_all(argument = nil)
    if argument.nil? && !block_given?
      for value in self do
        matches = value.nil? || !value == true
        break if matches
      end
      !matches
    elsif argument.nil?
      for value in self do
        matches = yield(value)
        break unless matches
      end
      matches
    elsif argument.is_a?(Regexp)
      for value in self do
        matches = value.to_s.match?(argument)
        break unless matches
      end
      matches
    elsif argument.is_a?(Class)
      for value in self do
        matches = value.is_a?(argument)
        break unless matches
      end
      matches
    else
      for value in self do
        matches = value == argument
        break unless matches
      end
      matches
    end
  end
end  
a = {
  "a" => 9,
  "b" => 8,
  "c" => 0,
  "d" => 4,
  "e" => 97,
  "f" => 82
}
a.my_each do |i , k|


end

