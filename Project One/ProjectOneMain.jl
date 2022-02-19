#=
Reminders for self: Check if the country exists first for command 1 > 1
=#
function main()
    # title sequence
    user_response = ""

    while user_response != "quit"
        # list of basic menu commands
        println("Type '1' for Vaccination Records")
        println("Type '2' for Mortality Records")
        println("Please Type a Command Number or 'quit' to leave: ")
        println()

        user_response = readline()

        # Vaccine commands 
        if (cmp(user_response, "1") == 0)
            vaccination_dict = vaccinations()
            command_num = ""
            while (command_num != "back")
                println("Type '1' to Retrieve the Quantity of People Vaccinated for a Country")
                println("Type '2' for the Top 10 Groups in terms of Vaccines")
                println("Type '3' for the Bottom 10 Groups in terms of Vaccines")
                println("Please Type a Command Number or 'back' to go back to the Main Menu: ")
                println()

                command_num = readline()
                if (command_num == "1")
                    println("Type a country: ")
                    country = readline()
                    println("There are " * string(get(vaccination_dict, country, 0)) * " vaccinated people for " * country)
                elseif (command_num == "2")
                    top_vaccinated(vaccination_dict)
                elseif (command_num == "3") 
                    
                else 
                    println("Not a valid command, please try again...")
                end
            end

        # Mortality commands
        elseif (cmp(user_response, "2") == 0)
            println("Type '1' Mortality Across All 3 Years (2020, 2021, 2022)")
            println("Type '2' Mortality Across All 3 Years")
        
        # For bad input commands from the user
        else 
            println("Not a valid command, please try again...")
        end

        
    end

end

#=
Processes the file vaccinations.csv file with the format:
location, iso_code, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, total_boosters, 
daily_vaccinations_raw, daily_vaccinations, total_vaccinations_per_hundred, people_vaccinated_per_hundred, 
people_fully_vaccinated_per_hundred, total_boosters_per_hundred, daily_vaccinations_per_million, 
daily_people_vaccinated, daily_people_vaccinated_per_hundred
=#
function vaccinations()
    # create a dictionary mapping locations to 
    vaccination_dict = Dict()
    file = open("vaccinations.csv", "r")
    readline(file)
    # goes through each of the CSV lines
    for line in readlines(file)
        line = split(line, ",")
        # arrays are apparently not zero indexed in Julia
        if (line[4] != "") 
            vaccination_dict[line[1]] = parse(Int64, line[4])
        end
    end
    close(file) 

    return vaccination_dict
end 

#=
Processes the file excess_mortality.csv file with the format:
location, date, p_scores_all_ages, p_scores_15_64, p_scores_65_74, p_scores_75_84, p_scores_85plus, 
deaths_2020_all_ages, average_deaths_2015_2019_all_ages,deaths_2015_all_ages, deaths_2016_all_ages,
deaths_2017_all_ages, deaths_2018_all_ages, deaths_2019_all_ages, deaths_2010_all_ages, 
deaths_2011_all_ages, deaths_2012_all_ages, deaths_2013_all_ages, deaths_2014_all_ages, deaths_2021_all_ages,
time,time_unit,p_scores_0_14, projected_deaths_2020_2022_all_ages, excess_proj_all_ages, cum_excess_proj_all_ages,
cum_proj_deaths_all_ages, cum_p_proj_all_ages, p_proj_all_ages, p_proj_0_14,p_proj_15_64,
p_proj_65_74, p_proj_75_84, p_proj_85p, cum_excess_per_million_proj_all_ages, excess_per_million_proj_all_ages,
deaths_2022_all_ages,deaths_2020_2022_all_ages
=#
function mortality()
    mortality_dict = Dict()
    file = open("excess_mortality.csv", "r")
    readline(file)

    # goes through each of the CSV lines
    for line in readlines(file)
        println(line)
    end
    close(file) 

    return mortality_dict
end

#=
Prints off the top ten vaccinated countries (in order)
=#
function top_vaccinated(vaccination_dict)
    top_ten = []
    for (k, v) in vaccination_dict
        println(top_ten)
         # makes sure the list is full of values 
        if (length(top_ten) == 0)
            push!(top_ten, k)
        elseif (length(top_ten) < 10)
            for index in range(1, length(top_ten))
                if (v > get(vaccination_dict, top_ten[index], 0))
                    insert!(top_ten, index, k)
                    break
                elseif(index == length(top_ten))
                    push!(top_ten, k)
                end
            end
        else 
            for index in 1:10
                if (v > get(vaccination_dict, top_ten[index], 0))
                    insert!(top_ten, index, k)
                    break
                end
            end
        end
        # ensures the array doesnt exceed 10 elements
        while (length(top_ten) > 10)
            pop!(top_ten)
        end
    end
    println(top_ten)
end 

main()