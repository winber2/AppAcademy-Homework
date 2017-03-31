def sum_to(n)
  return nil if n < 0
  return n if n == 0
  n + sum_to(n - 1)
end

def add_numbers(arr)
  return arr.first if arr.length <= 1
  arr.first + add_numbers(arr[1..-1])
end

def gamma_fnc(n)
  return nil if n <= 0
  return n if n == 1
  (n - 1) * gamma_fnc(n - 1)
end

def ice_cream_shop(flavors,favorite)
  return false if flavors.empty?
  return true if flavors.first == favorite
  flavors.shift
  ice_cream_shop(flavors,favorite)
end
