module  Enumerable

  def my_each 
    return to_enum :my_each unless block_given?
    item = self;
    i = 0
    while i < item.length
      if item.is_a?(Array)
        yield(item[i]) 
        i += 1
      elsif item.is_a?(Hash)
        yield item.keys[i],item[item.keys[i]]
        i += 1
      else
        yield(item)
      end 
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

  
