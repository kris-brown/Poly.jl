module TestSumProdPolynomials
export p,q,r,pr,pr_expected,pq,pq_expected

using Test
using Poly
using Catlab.CategoricalAlgebra.CSets


# SA⋅y^S + S⋅y^B
p = SumProdPoly{Symbol}([ [[:B]] => [:S], [[:S]] => [:S,:A] ])
q = SumProdPoly{Symbol}([ [[:A]] => [:B] ])
# y + A⋅y^(BS)
r = SumProdPoly{Symbol}([ [[:B],[:S]] => [:A] , [[]] => [] ])

p_plus_q_x = SumProdPoly{Symbol}([
    [[:B]] => [:S], [[:S]] => [:S,:A], [[:A]] => [:B]])

@test is_isomorphic(p+q, p_plus_q_x)

# Expected
p_ot_r_x = SumProdPoly{Symbol}([
           [[:B,:B],[:B,:S]] => [:A,:S],
           [[:B,:S], [:S,:S]] => [:S,:A,:A],
           [[:B]] => [:S],
           [[:S]] => [:S,:A]])

@test is_isomorphic(p⊗r,p_ot_r_x)

p_times_r_x = SumProdPoly{Symbol}([ # Expected
            [[:B],[:B],[:S]] => [:A,:S],
            [[:S],[:B],[:S]] => [:S,:A,:A],
            [[:B],[]] => [:S],
            [[:S],[]] => [:S,:A]])

p_times_r = times(p,r)

@test is_isomorphic(p_times_r, p_times_r_x)

end
