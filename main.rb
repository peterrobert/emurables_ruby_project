# rubocop: disable Metrics/ModuleLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
module Enumerable
  def my_each(&parm)
    return to_enum :my_each unless block_given?

    item = self
    i = 0
    while i < item.length
      if item.is_a?(Array)
        yield(item[i])
      elsif parm.arity == 1
        yield(assoc item.keys[i])
      else
        yield item.keys[i], item[item.keys[i]]
      end
      i += 1
    end
    item
  end

  def my_each_with_index(&parm)
    return to_enum :my_each unless block_given?

    item = self
    i = 0
    while i < item.length
      if item.is_a?(Array)
        yield item[i], i
      elsif parm.arity == 1
        yield(assoc item.keys[i])
      else
        yield item.keys[i], item[item.keys[i]], i
      end
      i += 1
    end
    item
  end

  def my_select
    return to_enum :my_select unless block_given?

    items = self

    items = items.to_a if items.is_a? Range

    if items.is_a?(Array)

      new_values = []

      items.my_each { |i| new_values.push(i) if yield(i) == true }

      new_values

    elsif items.is_a?(Hash)

      new_values = {}

      items.my_each { |a, b| new_values.store(a, b) if yield(a, b) == true }
      new_values
    else
      items
    end
  end

  def my_all?(parms = nil)
    item = self
    results = false
    if parms.nil? && !block_given?
      item.my_each do |value|
        results = value.nil? || !value == true
        break if results
      end
      !results
    elsif parms.nil?
      item.my_each do |value|
        results = yield(value)
        break unless results
      end
      results
    elsif parms.is_a?(Regexp)
      item.my_each do |value|
        results = value.to_s.match?(parms)
        break unless results
      end
      results
    elsif parms.is_a?(Class)
      item.my_each do |value|
        results = value.is_a?(parms)
        break unless results
      end
      results
    else
      item.my_each do |value|
        results = value == parms
        break unless results
      end
      results
    end
  end

  def my_any?(*parms)
    item = self
    res = false
    if block_given?
      item.my_each do |i|
        res = true if yield(i)
      end
    elsif !parms[0].nil?
      item.my_each do |i|
        res = true if parms[0] == i
      end
    elsif item.empty? && parms[0].nil?
      res = false
    else
      item.my_each do |i|
        res = true if yield(i)
      end
    end
    res
  end

  def my_none?(*parms)
    my_each_with_index do |item, i|
      if block_given?
        return false if yield(item)
      elsif parms.length == 1
        return false if parms[0] == item
      elsif item == true
        return false
      end
      return true if i == length - 1
    end
    true if length.zero?
  end

  def my_count(*parms)
    return_value = 0
    sum_one = ->(bool) { return_value += 1 if bool }

    if block_given?
      my_each { |i| sum_one.call(yield(i)) }
    else
      my_each { |i| parms.empty? ? return_value += 1 : sum_one.call(parms[0] == i) }
    end

    return_value
  end

  def my_map(parms = nil)
    return to_enum(:my_map) unless block_given?

    mapped = []
    my_each { |i| mapped << parms.call(i) } if block_given? && parms
    my_each { |i| mapped << yield(i) } if parms.nil?
    mapped
  end

  def my_inject(results = nil, sym = nil, &parms)
    results = results.to_sym if results.is_a?(String) && !sym && !parms

    if results.is_a?(Symbol) && !sym
      parms = results.to_proc
      results = nil
    end

    sym = sym.to_sym if sym.is_a?(String)
    parms = sym.to_proc if sym.is_a?(Symbol)

    my_each { |i| results = results.nil? ? i : parms.yield(results, i) }
    results
  end
end

def multiply_els(my_array)
  my_array.my_inject { |result, value| result * value }
end

# rubocop: enable Metrics/ModuleLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength:
