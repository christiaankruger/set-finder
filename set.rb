QUANTITIES = ['1', '2', '3']
SHAPES = ['D', 'S', 'C']
COLORS = ['R', 'P', 'G']
SHADES = ['E', 'L' 'S']

# :quantity (1,2,3)
# :shape (D(iamond), S(quiggly), C(ircle))
# :color (R(ed), P(urple), G(green))
# :shade (E(mpty), L(ines), S(solid))

def build_set_object(notation)
    notation.upcase!
    {
        quantity: notation[0],
        shape: notation[1],
        color: notation[2],
        shade: notation[3]
    }
    # TODO: Validation
end

# Are two set objects equal?
def _equals(a, b)
    [:quantity, :shape, :color, :shade].all? do |p|
        a[p] == b[p]
    end
end

def associated_array(property)
    case property
    when :quantity
        QUANTITIES
    when :color
        COLORS
    when :shape
        SHAPES
    when :shade
        SHADES
    end
end

# Extracts the value
# Due to array subraction, k can be an array
def _(k)
    return k if k.class != Array
    k[0]
end

def find_third_item(first, second)
    # We have two set objects
    # What does the third one have to look like?
    result = {}
    [:quantity, :shape, :color, :shade].each do |p|
        result[p] =
            # Are the two properties the same?
            first[p] == second[p] ?
            # Yes. Third should be the same
            first[p] :
            # No. Third should be the third one
            _(associated_array(p) - [first[p], second[p]])
    end
    result
end

list = []

list.push(build_set_object("1DRE"))
list.push(build_set_object("2DRE"))
list.push(build_set_object("3DRE"))

set_exists = list.combination(2).map do |a, b|
    c = find_third_item(a, b)
    list.any? {|k| _equals(k, c)}
end.any?

puts set_exists
