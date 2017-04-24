type TigerPOMDP <: POMDP{Bool, Int64, Bool}
    r_listen::Float64
    r_findtiger::Float64
    r_escapetiger::Float64
    p_listen_correctly::Float64
    discount_factor::Float64
end
TigerPOMDP() = TigerPOMDP(-1.0, -100.0, 10.0, 0.85, 0.95)

state_index(::TigerPOMDP, s::Bool) = Int64(s) + 1
action_index(::TigerPOMDP, a::Int) = a + 1
obs_index(::TigerPOMDP, o::Bool) = Int64(o) + 1

initial_belief(::TigerPOMDP) = DiscreteBelief(2)

const TIGER_LISTEN = 0
const TIGER_OPEN_LEFT = 1
const TIGER_OPEN_RIGHT = 2

const TIGER_LEFT = true
const TIGER_RIGHT = false

type TigerDistribution
    p::Float64
    it::Vector{Bool}
end
TigerDistribution() = TigerDistribution(0.5, [true, false])
iterator(d::TigerDistribution) = d.it

#Base.length(d::AbstractTigerDistribution) = d.interps.length
#weight(d::AbstractTigerDistribution, i::Int64) = d.interps.weights[i]
#index(d::AbstractTigerDistribution, i::Int64) = d.interps.indices[i]

function pdf(d::TigerDistribution, so::Bool)
    so ? (return d.p) : (return 1.0-d.p)
end

rand(rng::AbstractRNG, d::TigerDistribution) = rand(rng) <= d.p

n_states(::TigerPOMDP) = 2
n_actions(::TigerPOMDP) = 3
n_observations(::TigerPOMDP) = 2

# Resets the problem after opening door; does nothing after listening
function transition(pomdp::TigerPOMDP, s::Bool, a::Int64)
    d = TigerDistribution()
    if a == 1 || a == 2
        d.p = 0.5
    elseif s
        d.p = 1.0
    else
        d.p = 0.0
    end
    d
end

function observation(pomdp::TigerPOMDP, a::Int64, sp::Bool)
    d = TigerDistribution()
    pc = pomdp.p_listen_correctly
    if a == 0
        sp ? (d.p = pc) : (d.p = 1.0-pc)
    else 
        d.p = 0.5
    end
    d
end

function observation(pomdp::TigerPOMDP, s::Bool, a::Int64, sp::Bool)
    return observation(pomdp, a, sp)
end


function reward(pomdp::TigerPOMDP, s::Bool, a::Int64)
    r = 0.0
    a == 0 ? (r+=pomdp.r_listen) : (nothing)
    if a == 1
        s ? (r += pomdp.r_findtiger) : (r += pomdp.r_escapetiger)
    end
    if a == 2
        s ? (r += pomdp.r_escapetiger) : (r += pomdp.r_findtiger)
    end
    return r
end
reward(pomdp::TigerPOMDP, s::Bool, a::Int64, sp::Bool) = reward(pomdp, s, a)


initial_state_distribution(pomdp::TigerPOMDP) = TigerDistribution(0.5, [true, false])     

actions(::TigerPOMDP) = [0,1,2]

function upperbound(pomdp::TigerPOMDP, s::Bool)
    return pomdp.r_escapetiger 
end

discount(pomdp::TigerPOMDP) = pomdp.discount_factor

function generate_o(p::TigerPOMDP, s::Bool, rng::AbstractRNG)
    d = observation(p, 0, s) # obs distrubtion not action dependant
    return rand(rng, d)
end

# same for both state and observation
Base.convert(::Type{Array{Float64}}, so::Bool, p::TigerPOMDP) = Float64[so]
Base.convert(::Type{Bool}, so::Vector{Float64}, p::TigerPOMDP) = Bool(so[1])

# This doesn't seem to work well
# type TigerBeliefUpdater <: Updater{DiscreteBelief}
#     pomdp::TigerPOMDP
# end
# 
# function update(bu::TigerBeliefUpdater, bold::DiscreteBelief, a::Int64, o::Bool)
#     bl = bold[1]
#     br = bold[2]
#     p = bu.pomdp.p_listen_correctly
#     if a == 0
#         if o
#             bl *= p
#             br *= (1.0-p)
#         else
#             bl *= (1.0-p)
#             br *= p
#         end
#     else
#         bl = 0.5
#         br = 0.5
#     end
#     norm = bl+br
#     b[1] = bl / norm
#     b[2] = br / norm
#     b
# end
