-- Function to retrieve job data for an officer on duty
function GetOnDutyJobData(department, current_rank)
    local ranks = config.Police_Ranks[department]
    if not ranks then
        return false, "Invalid department: " .. tostring(department)
    end

    for i, rank in ipairs(ranks) do
        if rank == current_rank then
            return true, {
                department = department,
                rank = rank,
                rankIndex = i
            }
        end
    end

    return nil, "Invalid rank: " .. tostring(current_rank)
end

function GetTotalEmployees(department)
    local ranks = config.Police_Ranks[department]
    if not ranks then return 0 end
    return #ranks
end

exports("GetTotalEmployees", GetTotalEmployees)

function Promoteofficer(department, current_rank)
    if not config.Police_onduty then
        local success, data = GetOnDutyJobData(department, current_rank)
        if not success then
            print(data)
            return false
        end

        local ranks = config.Police_Ranks[department]
        local i = data.rankIndex

        if i < #ranks then
            return ranks[i + 1]
        else
            return data.rank
        end
    end
    return current_rank
end

function demoteofficer(department, current_rank)
    if not config.Police_onduty then
        local success, data = GetOnDutyJobData(department, current_rank)
        if not success then
            print(data)
            return false
        end

        local ranks = config.Police_Ranks[department]
        local i = data.rankIndex

        if i > 1 then
            return ranks[i - 1]
        else
            return data.rank
        end
    end
    return current_rank
end


exports("Promoteofficer", Promoteofficer)
exports("demoteofficer", demoteofficer)

RegisterCommand("Setrank", function(source, args, rawCommand)
    local department = args[1]
    local rank = args[2]

    -- Check for missing arguments
    if not department or not rank then
        print("Usage: /Setrank [department] [current_rank]")
        return
    end

    -- Validate department exists
    local ranks = config.Police_Ranks[department]
    if not ranks then
        print("Error: Department '" .. tostring(department) .. "' does not exist!")
        return
    end

    -- Validate rank exists in the department
    local rankFound = false
    for _, r in ipairs(ranks) do
        if r == rank then
            rankFound = true
            break
        end
    end

    if not rankFound then
        print("Error: Rank '" .. tostring(rank) .. "' is not valid for " .. department)
        return
    end

    -- Attempt promotion
    local new_rank = Promoteofficer(department, rank)

    if not new_rank then
        demoteofficer(department, rank)
        return
    end

    print("New Rank: " .. new_rank)
end, true) 