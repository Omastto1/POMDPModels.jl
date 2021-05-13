# Hallway problem defined in http://cs.brown.edu/research/ai/pomdp/examples/hallway.POMDP.gz.
# Original idea published in Littman, Cassandra and Kaelbling's ML-95 paper.

# The problem definition implementation is not fully optimized!

# Basic parameters are:
# discount: 0.950000
# values: reward
# states: 60
# actions: 5
# observations: 21
# The rest is available at link


struct Hallway <: POMDP{Int, Int, Int}
    T_a
    O
end

function Hallway()
    T_a = Base.ImmutableDict(
        1 => SparseCat([6, 1], [.05, .95]),
        2 => SparseCat([6, 2], [.8, .2]),
        3 => SparseCat([6, 3], [.05, .95]),
        4 => SparseCat([6, 8, 4], [.025, .025, .95]),
        5 => SparseCat([10, 4, 5], [.05, .05, .9]),
        6 => SparseCat([10, 2, 4, 6], [.8, .025, .025, .15]),
        7 => SparseCat([10, 4, 7], [.05, .05, .9]),
        8 => SparseCat([10, 12, 4, 8], [.025, .025, .8, .15]),
        9 => SparseCat([14, 45, 47, 8, 9], [.05, .025, .025, .05, .85]),
        10 => SparseCat([14, 47, 6, 8, 10], [.8, .05, .025, .025, .1]),
        11 => SparseCat([14, 47, 8, 11], [.05, .8, .05, .1]),
        12 => SparseCat([14, 16, 47, 8, 12], [.025, .025, .05, .8, .1]),
        13 => SparseCat([18, 12, 13], [.05, .05, .9]),
        14 => SparseCat([18, 10, 12, 14], [.8, .025, .025, .15]),
        15 => SparseCat([18, 12, 15], [.05, .05, .9]),
        16 => SparseCat([18, 20, 12, 16], [.025, .025, .8, .15]),
        17 => SparseCat([22, 49, 51, 16, 17], [.05, .025, .025, .05, .85]),
        18 => SparseCat([22, 51, 14, 16, 18], [.8, .05, .025, .025, .1]),
        19 => SparseCat([22, 51, 16, 19], [.05, .8, .05, .1]),
        20 => SparseCat([22, 24, 51, 16, 20], [.025, .025, .05, .8, .1]),
        21 => SparseCat([26, 20, 21], [.05, .05, .9]),
        22 => SparseCat([26, 18, 20, 22], [.8, .025, .025, .15]),
        23 => SparseCat([26, 20, 23], [.05, .05, .9]),
        24 => SparseCat([26, 28, 20, 24], [.025, .025, .8, .15]),
        25 => SparseCat([30, 53, 55, 24, 25], [.05, .025, .025, .05, .85]),
        26 => SparseCat([30, 55, 22, 24, 26], [.8, .05, .025, .025, .1]),
        27 => SparseCat([30, 55, 24, 27], [.05, .8, .05, .1]),
        28 => SparseCat([30, 32, 55, 24, 28], [.025, .025, .05, .8, .1]),
        29 => SparseCat([34, 28, 29], [.05, .05, .9]),
        30 => SparseCat([34, 26, 28, 30], [.8, .025, .025, .15]),
        31 => SparseCat([34, 28, 31], [.05, .05, .9]),
        32 => SparseCat([34, 36, 28, 32], [.025, .025, .8, .15]),
        33 => SparseCat([38, 57, 59, 32, 33], [.05, .025, .025, .05, .85]),
        34 => SparseCat([38, 59, 30, 32, 34], [.8, .05, .025, .025, .1]),
        35 => SparseCat([38, 59, 32, 35], [.05, .8, .05, .1]),
        36 => SparseCat([38, 40, 59, 32, 36], [.025, .025, .05, .8, .1]),
        37 => SparseCat([42, 36, 37], [.05, .05, .9]),
        38 => SparseCat([42, 34, 36, 38], [.8, .025, .025, .15]),
        39 => SparseCat([42, 36, 39], [.05, .05, .9]),
        40 => SparseCat([42, 44, 36, 40], [.025, .025, .8, .15]),
        41 => SparseCat([40, 41], [.05, .95]),
        42 => SparseCat([38, 40, 42], [.025, .025, .95]),
        43 => SparseCat([40, 43], [.05, .95]),
        44 => SparseCat([40, 44], [.8, .2]),
        45 => SparseCat([9, 45], [.8, .2]),
        46 => SparseCat([9, 46], [.05, .95]),
        47 => SparseCat([9, 11, 47], [.025, .025, .95]),
        48 => SparseCat([9, 48], [.05, .95]),
        49 => SparseCat([17, 49], [.8, .2]),
        50 => SparseCat([17, 50], [.05, .95]),
        51 => SparseCat([17, 19, 51], [.025, .025, .95]),
        52 => SparseCat([17, 52], [.05, .95]),
        53 => SparseCat([25, 53], [.8, .2]),
        54 => SparseCat([25, 54], [.05, .95]),
        55 => SparseCat([25, 27, 55], [.025, .025, .95]),
        56 => SparseCat([25, 56], [.05, .95]),
        57 => SparseCat([57], [1.]),
        58 => SparseCat([58], [1.]),
        59 => SparseCat([59], [1.]),
        60 => SparseCat([60], [1.])
    )

    O = Base.ImmutableDict(
        1 => [0.000949, 0.008549, 0.008549, 0.076949, 0.000049, 0.000449, 0.000449, 0.004049, 0.008549, 0.076949, 0.076949, 0.692550, 0.000449, 0.004049, 0.004049, 0.036464 , 0.0, 0.0, 0.0, 0.0, 0.0],
        2 => [0.000949, 0.008549, 0.008549, 0.076949, 0.008549, 0.076949, 0.076949, 0.692550, 0.000049, 0.000449, 0.000449, 0.004049, 0.000449, 0.004049, 0.004049, 0.036464 , 0.0, 0.0, 0.0, 0.0, 0.0],
        3 => [0.000949, 0.000049, 0.008549, 0.000449, 0.008549, 0.000449, 0.076949, 0.004049, 0.008549, 0.000449, 0.076949, 0.004049, 0.076949, 0.004049, 0.692550, 0.036464 , 0.0, 0.0, 0.0, 0.0, 0.0],
        4 => [0.000949, 0.008549, 0.000049, 0.000449, 0.008549, 0.076949, 0.000449, 0.004049, 0.008549, 0.076949, 0.000449, 0.004049, 0.076949, 0.692550, 0.004049, 0.036464 , 0.0, 0.0, 0.0, 0.0, 0.0],
        5 => [0.009024, 0.000474, 0.081225, 0.004275, 0.000474, 0.000024, 0.004275, 0.000225, 0.081225, 0.004275, 0.731024, 0.038475, 0.004275, 0.000225, 0.038475, 0.002030 , 0.0, 0.0, 0.0, 0.0, 0.0],
        6 => [0.009024, 0.081225, 0.000474, 0.004275, 0.081225, 0.731024, 0.004275, 0.038475, 0.000474, 0.004275, 0.000024, 0.000225, 0.004275, 0.038475, 0.000225, 0.002030 , 0.0, 0.0, 0.0, 0.0, 0.0],
        7 => [0.085737, 0.004512, 0.004512, 0.000237, 0.004512, 0.000237, 0.000237, 0.000012, 0.771637, 0.040612, 0.040612, 0.002137, 0.040612, 0.002137, 0.002137, 0.000120 , 0.0, 0.0, 0.0, 0.0, 0.0],
        8 => [0.085737, 0.771637, 0.004512, 0.040612, 0.004512, 0.040612, 0.000237, 0.002137, 0.004512, 0.040612, 0.000237, 0.002137, 0.000237, 0.002137, 0.000012, 0.000120 , 0.0, 0.0, 0.0, 0.0, 0.0],
        9 => [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,  1.0, 0.0, 0.0, 0.0, 0.0],
        10 => [0.085737, 0.004512, 0.004512, 0.000237, 0.771637, 0.040612, 0.040612, 0.002137, 0.004512, 0.000237, 0.000237, 0.000012, 0.040612, 0.002137, 0.002137, 0.000120 , 0.0, 0.0, 0.0, 0.0, 0.0],
        11 => [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0],
        12 => [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0],
        13 => [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0],
        14 => [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]
    )
    return Hallway(T_a, O)
end


##################
# mdps interface #
##################
POMDPs.states(m::Hallway) = 1:60
POMDPs.stateindex(m::Hallway, ss::Int)::Int = ss
POMDPs.isterminal(m::Hallway, ss::Int)::Bool =  stateindex(m, ss) == 57 || stateindex(m, ss) == 58 ||
                                                stateindex(m, ss) == 59 || stateindex(m, ss) == 60

function POMDPs.transition(m::Hallway, ss::Int, a::Int)
    if isterminal(m, ss)
        return m.T_a[stateindex(m, ss)]
    else                                # scary data structure, but should be ok
        if a == 1
            return Deterministic(ss)
        elseif a == 2
            return m.T_a[stateindex(m, ss)]
        else
            base_sp = floor(Int, ss / 4) * 4
            sps = collect(base_sp : base_sp + 3) .+ 1
            if a == 3
                probs = fill(0.1, 4)
                idx = (ss + 1) % 4
                probs[idx == 0 ? 4 : idx] = .7
                return SparseCat(sps, probs)
            elseif a == 4
                probs = [.15, .6, .15, .1]
                probs = circshift(probs, ss % 4)
                return SparseCat(sps, probs)
            elseif a == 5
                probs = fill(0.1, 4)
                idx = (ss + 3) % 4
                probs[idx == 0 ? 4 : idx] = .7
                return SparseCat(sps, probs)
            else
                error("Unknown action ", a, " in POMDP ", m, " from state ", ss)
            end
        end
    end
end

POMDPs.actions(m::Hallway) = 1:5
POMDPs.actionindex(m::Hallway, a::Int)::Int = a

POMDPs.reward(m::Hallway, ss::Int, a::Int, sp::Int) = float(ss != sp && isterminal(m, sp))
POMDPs.reward(m::Hallway, ss::Int, a::Int) = mean_reward(m, ss, a)
POMDPs.discount(m::Hallway)::Float64 = 0.95

####################
# pomdps interface #
####################
POMDPs.initialstate(m::Hallway) = SparseCat(collect(1:56),  [0.017865, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857,
                                                             0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857,
                                                             0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857,
                                                             0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857, 0.017857,
                                                             0.017857, 0.017857, 0.017857, 0.017857])
POMDPs.observations(m::Hallway) = (i for i in 1:21)

function POMDPs.observation(m::Hallway, a::Int, sp::Int)
    if sp in (1, 43, 48, 52, 56)
        return SparseCat(1:21, m.O[1])
    elseif sp in (2, 44, 45, 49, 53)
        return SparseCat(1:21, m.O[2])
    elseif sp in (3, 41, 46, 50, 54)
        return SparseCat(1:21, m.O[3])
    elseif sp in (4, 42, 47, 51, 55)
        return SparseCat(1:21, m.O[4])
    elseif sp in (5, 7, 13, 15, 21, 23, 29, 31, 37, 39)
        return SparseCat(1:21, m.O[5])
    elseif sp in (6, 8, 14, 16, 22, 24, 30, 32, 38, 40)
        return SparseCat(1:21, m.O[6])
    elseif sp in (9, 17, 25, 33)
        return SparseCat(1:21, m.O[7])
    elseif sp in (10, 18, 26, 34)
        return SparseCat(1:21, m.O[8])
    elseif sp == 11
        return SparseCat(1:21, m.O[9])
    elseif sp in (12, 20, 28, 36)
        return SparseCat(1:21, m.O[10])
    elseif sp == 19
        return SparseCat(1:21, m.O[11])
    elseif sp == 27
        return SparseCat(1:21, m.O[12])
    elseif sp == 35
        return SparseCat(1:21, m.O[13])
    elseif sp in (57, 58, 59, 60)
        return SparseCat(1:21, m.O[14])
    end
end

POMDPs.observation(m::Hallway, s::Int, a::Int, sp::Int) = observation(m, a, sp)
POMDPs.obsindex(m::Hallway, o::Int)::Int = o

Base.broadcastable(m::Hallway) = Ref(m)
