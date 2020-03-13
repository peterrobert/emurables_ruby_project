module  Enumerable

  def my_self 
   
    item = self;
    i = 0

    while i < item.length

      if item.is_a?(Array)
 
        yield(item[i])

        i += 1
 
      elsif item.is_a?(Hash)

        yield(item.keys[i], item[item.keys[i]])

        i += 1

      else
        yield(item)
      end 
    end
  end


  def my_each_with_index 

    item = self;
    i = 0

    while i < item.length

      if item.is_a?(Array)
 
        yield([i],item[i])

        i += 1
 
      elsif item.is_a?(Hash)

        yield([i],item.keys[i], item[item.keys[i]])

        i += 1

      else

        yield(item)

      end 
    end


  end
  


















  test = ["peter","robert","hey there","mary"];
   
  test_it = {
   "name" => "peter",
    "hate" => "peter",
    "hey" => "peter",
    "why" => "peter",
  };

  test_hell = "hey there"



  puts test_it.my_each_with_index
end