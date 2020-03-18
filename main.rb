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
  
  
