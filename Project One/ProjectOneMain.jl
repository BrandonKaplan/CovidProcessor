#=
AUTHORS: Brandon Kaplan and Edward Botterbusch
CLASS: CSC 372 - Comparative Programming Spring 2022
PROJECT: Program one
DESCRIPTION: The purpose of this program is to demonstrate the efficiency of Julia
by utlizing it's capabilities of large mathematical computations and big data sets
through computing various statistics based on data for COVID-19. This program uses 
two different csv files that contains between 82,000 to 125,000 different data lines
on vaccine data and hospitalization data. The user can explore either of these sets
or time the program on how long it takes to perform the computations. Within each of
the commands for the data, the user can get the statistic for group/country, get the
average for the datasets, get the top ten highest and lowest vaccinated/hospitalization.

TO RUN: Run this file, ProjectOneMain.jl

DATASET CREDIT: https://ourworldindata.org/coronavirus
RELATED FILES: covid-hospitalizations.csv, vaccinations.csv 
IMPORTANT NOTE: Must need above files in directory to run correctly, formatting for these
files are shown below
=#
function main()
    # title sequence
    user_response = ""

    # continues to ask the user till they quit
    while user_response != "quit"
        # list of basic menu commands
        println("Type '1' for Vaccination Records")
        println("Type '2' for Hospitalization Records")
        println("Type '3' to time program")
        println("Please Type a Command Number or 'quit' to leave: ")
        println()

        user_response = readline()

        # Vaccine Dataset commands 
        if (cmp(user_response, "1") == 0)
            vaccination_dict = vaccinations()
            command_num = ""
            while (command_num != "back")
                println("Type '1' to Retrieve the Quantity of People Vaccinated for a Country")
                println("Type '2' for the Top 10 Groups in terms of Vaccines")
                println("Type '3' for the Bottom 10 Groups in terms of Vaccines")
                println("Type '4' for the average amount vaccinated across all groups")
                println("Please Type a Command Number or 'back' to go back to the Main Menu: ")
                println()

                command_num = readline()

                # Gets amount per country
                if (command_num == "1")
                    println("Type a country: ")
                    country = readline()
                    println()
                    println("There are " * string(get(vaccination_dict, country, "(country not found)")) * " vaccinated people for " * country)
                    println()
                # Gets the top ten vaccinated groups
                elseif (command_num == "2")
                    top_vaccinated(vaccination_dict)
                # gets the lowest vaccinated groups
                elseif (command_num == "3") 
                    bottom_vaccinated(vaccination_dict)
                # gets the average vaccinated globally
                elseif (command_num == "4") 
                    average_vaccinated(vaccination_dict)
                # if the user enters a bad command
                else 
                    println("Not a valid command, please try again...")
                end
            end

        # Hospitalization Commands
        elseif (cmp(user_response, "2") == 0)
            hospitalization_dict = hospitalizations()
            command_num = ""
            while (command_num != "back")
                println("Type '1' to get the Average Hospitalizations for a Country")
                println("Type '2' to get the Average Hospitalizations for the World")
                println("Type '3' to get the Highest Average Hospitalizations per Country")
                println("Type '4' to get the Lowest Average Hospitalizations per Country")
                println("Please Type a Command Number or 'back' to go back to the Main Menu: ")
                println()

                command_num = readline()

                # gets daily hospitalization by country
                if (command_num == "1")
                    println("Enter the name of a Country ")
                    country = readline()
                    totals = get(hospitalization_dict, country, -1)
                    if (totals == -1)
                        println("Country not Found")
                    else 
                        average = totals[1] ÷ totals[2]
                        println("The Average Hospitalizations for " * country * " is " * string(average) * " people per day")
                        println()
                    end
                # gets global hospitalization average
                elseif (command_num == "2")
                    average_global_hospitalizations(hospitalization_dict)
                # gets the highest amount of hospitalizations
                elseif (command_num == "3")
                    top_hospitalizations(hospitalization_dict)
                # gets the lowest amount of hospitalizations
                elseif (command_num == "4")
                    lowest_hospitalizations(hospitalization_dict)
                # if the user enters a bad command
                else 
                    println("Not a valid command, please try again...")
                end
            end 
        # times the program
        elseif (cmp(user_response, "3") == 0)
            println()
            println("hospitalizations() method took: ")
            @time hospitalizations
            println("vaccinations() method took: ")
            @time vaccinations
            println()

        # For bad input commands from the user
        else 
            println("Not a valid command, please try again...")
        end
    end
end

#=
Processes the file covid-hospitalizations.csv file with the format
    entity, iso_code, date, indicator, value

Creates a dictionary with the countries as keys (as strings) with 
the value be an array of size 2 that is [total hospitalizations, total
days]

Important note has to avoid anything else when the indicator is not
"Daily ICU occupancy"

Returns the hospitalization data dictionary as described above
=#
function hospitalizations()
    # create a dictionary mapping locations to 
    hospitalization_dict = Dict()
    file = open("covid-hospitalizations.csv", "r")
    readline(file)
    # goes through each of the CSV lines
    for line in readlines(file)
        line = split(line, ",")
        if (line[4] == "Daily ICU occupancy") 
            country = line[1]
            value = get(hospitalization_dict, country, -1)
            if (value == -1)
                # puts the first quantity of hospitalizations and 
                value = [parse(Float64, line[5]), 1]
                hospitalization_dict[country] = value
            else 
                new_value = [value[1] + parse(Float64, line[5]), value[2] + 1]
                hospitalization_dict[country] = new_value
            end
        end
    end
    close(file) 
    return hospitalization_dict
end

    

#=
Processes the file vaccinations.csv file with the format:
location, iso_code, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, total_boosters, 
daily_vaccinations_raw, daily_vaccinations, total_vaccinations_per_hundred, people_vaccinated_per_hundred, 
people_fully_vaccinated_per_hundred, total_boosters_per_hundred, daily_vaccinations_per_million, 
daily_people_vaccinated, daily_people_vaccinated_per_hundred

Iterates through the CSV taking the maximum record of vaccinations per country by storing the data
in a dictionary where the keys are strings (countries) and integers as the values (that represents
the amount of vaccines for that country)

Returns the Dictionary vaccine data as described
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
Prints off the top ten vaccinated countries (in order) 

Takes in the vaccination data as a form of a dictionary where
the keys are strings (countries) and the values are integers which
represents the amount vaccinated
=#
function top_vaccinated(vaccination_dict)
    top_ten = []
    for (k, v) in vaccination_dict
         # makes sure the list has at least one value to start
        if (length(top_ten) == 0)
            push!(top_ten, k)
        # adds keys until there is at least 10 (must be sorted though)
        elseif (length(top_ten) < 10)
            for index in range(1, length(top_ten))
                if (v > get(vaccination_dict, top_ten[index], 0))
                    insert!(top_ten, index, k)
                    break
                elseif(index == length(top_ten))
                    push!(top_ten, k)
                end
            end
        # compares if any of the current keys are less than the current value
        else 
            for index in 1:10
                if (v > get(vaccination_dict, top_ten[index], 0))
                    insert!(top_ten, index, k)
                    break
                end
            end
        end
        # ensures the array doesnt exceed 10 elements due to insertion
        while (length(top_ten) > 10)
            pop!(top_ten)
        end
    end
    # print off the top ten vaccinated groups
    println()
    println("Top Ten Vaccinated Groups: ")
    for group in top_ten
        println("   " * string(get(vaccination_dict, group, 0)) * "  vaccinated for " * group)
    end
    println()
end 

#=
Prints off the bottom ten vaccinated countries (in order)

Takes in the vaccination data as a form of a dictionary where
the keys are strings (countries) and the values are integers which
represents the amount vaccinated
=#
function bottom_vaccinated(vaccination_dict)
    bottom_ten = []
    for (k, v) in vaccination_dict
         # makes sure the list has at least one value to start
        if (length(bottom_ten) == 0)
            push!(bottom_ten, k)
        # adds keys until there is at least 10 (must be sorted though)
        elseif (length(bottom_ten) < 10)
            for index in range(1, length(bottom_ten))
                if (v < get(vaccination_dict, bottom_ten[index], 0))
                    insert!(bottom_ten, index, k)
                    break
                elseif(index == length(bottom_ten))
                    push!(bottom_ten, k)
                end
            end
        # compares if any of the current keys are greater than the current value
        else 
            for index in 1:10
                if (v < get(vaccination_dict, bottom_ten[index], 0))
                    insert!(bottom_ten, index, k)
                    break
                end
            end
        end
        # ensures the array doesnt exceed 10 elements due to insertion
        while (length(bottom_ten) > 10)
            pop!(bottom_ten)
        end
    end

    # print off the bottom ten vaccinated groups
    println()
    println("Bottom Ten Vaccinated Groups: ")
    for group in bottom_ten
        println("   " * string(get(vaccination_dict, group, 0)) * "  vaccinated for " * group)
    end
    println()
end 

#=
Calculates the average amount of vaccinated people among the groups

Takes in the vaccination data as a form of a dictionary where
the keys are strings (countries) and the values are integers which
represents the amount vaccinated
=#
function average_vaccinated(vaccination_dict)
    group_size = 0
    vaccinated = 0
    # iterates for all the key/value pairs in the dictionary
    for (key, value) in vaccination_dict
        group_size = group_size + 1
        vaccinated = vaccinated + value
    end 
    average = vaccinated ÷ group_size
    println()
    println("For the " * string(group_size) * " groups, " * string(average) * " people are vaccinated on average")
    println()

end

#= 
Calculates the average of the average daily hospitalizations by adding 
all the total countries daily averages to a total and then dividing by 
the quantity of countries

Takes in the hospitalization data as a form of a dictionary where
the keys are strings (countries) and the values are an integer array
of days and amount of total people hospitalized daily
=#
function average_global_hospitalizations(hospitalization_dict)
    total_average = 0.0
    total_countries = 0
    for (key, value) in hospitalization_dict
        # calculates the daily average for a country first
        country_average = value[1] ÷ value[2]
        total_average = total_average + country_average
        total_countries = total_countries + 1
    end 
    global_average = total_average ÷ total_countries
    println()
    println("The average daily hospitalizations globally is " * string(global_average) * " people")
    println()
end

#=
Calculates the highest ten countries in Hospitalizations

Takes in the hospitalization data as a form of a dictionary where
the keys are strings (countries) and the values are an integer array
of days and amount of total people hospitalized daily
=#
function top_hospitalizations(hospitalization_dict)
    top_ten = []
    for (k, v) in hospitalization_dict
        country_average = v[1] ÷ v[2]
         # makes sure the list has at least one value to start
        if (length(top_ten) == 0)
            push!(top_ten, k)
        # adds keys until there is at least 10 (must be sorted though)
        elseif (length(top_ten) < 10)
            for index in range(1, length(top_ten))
                val = get(hospitalization_dict, top_ten[index], -1)
                current_average = val[1] ÷ val[2]
                if (country_average > current_average)
                    insert!(top_ten, index, k)
                    break
                elseif(index == length(top_ten))
                    push!(top_ten, k)
                end
            end
        # compares if any of the current keys are less than the current value
        else 
            for index in 1:10
                val = get(hospitalization_dict, top_ten[index], -1)
                current_average = val[1] ÷ val[2]
                if (country_average > current_average)
                    insert!(top_ten, index, k)
                    break
                end
            end
        end
        # ensures the array doesnt exceed 10 elements due to insertion
        while (length(top_ten) > 10)
            pop!(top_ten)
        end
    end
    # print off the top ten vaccinated groups
    println()
    println("Top Ten Highest Hospitalization Daily Averages: ")
    for group in top_ten
        val = get(hospitalization_dict, group, 0)
        ave = val[1] ÷ val[2]
        println("   " * string(ave) * "  hospitalizations for " * group)
    end
    println()
end

#=
Calculates the lowest ten countries in Hospitalizations

Takes in the hospitalization data as a form of a dictionary where
the keys are strings (countries) and the values are an integer array
of days and amount of total people hospitalized daily
=#
function lowest_hospitalizations(hospitalization_dict)
    top_ten = []
    for (k, v) in hospitalization_dict
        country_average = v[1] ÷ v[2]
         # makes sure the list has at least one value to start
        if (length(top_ten) == 0)
            push!(top_ten, k)
        # adds keys until there is at least 10 (must be sorted though)
        elseif (length(top_ten) < 10)
            for index in range(1, length(top_ten))
                val = get(hospitalization_dict, top_ten[index], -1)
                current_average = val[1] ÷ val[2]
                if (country_average < current_average)
                    insert!(top_ten, index, k)
                    break
                elseif(index == length(top_ten))
                    push!(top_ten, k)
                end
            end
        # compares if any of the current keys are less than the current value
        else 
            for index in 1:10
                val = get(hospitalization_dict, top_ten[index], -1)
                current_average = val[1] ÷ val[2]
                if (country_average < current_average)
                    insert!(top_ten, index, k)
                    break
                end
            end
        end
        # ensures the array doesnt exceed 10 elements due to insertion
        while (length(top_ten) > 10)
            pop!(top_ten)
        end
    end
    # print off the top ten vaccinated groups
    println()
    println("Top Ten Lowest Hospitalization Daily Averages: ")
    for group in top_ten
        val = get(hospitalization_dict, group, 0)
        ave = val[1] ÷ val[2]
        println("   " * string(ave) * "  hospitalizations for " * group)
    end
    println()
end

main()