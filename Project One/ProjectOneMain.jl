function main()
    # title sequence
    user_response = ""

    while user_response != "quit"
        # list of commands:
        println("Type '1' for Vaccination Records")
        println("Please Type a Command Number: ")

        user_response = readline()

        # Vaccine commands 
        if (cmp(user_response, "1") == 0)
            vaccination_dict = vaccinations()
            println("Type '1' and a Country Name to Retrieve Quantity of Vaccines")
            println("Type '2' for the Top 10 Countries in terms of Vaccines")
            println("Type '3' for the Bottom 10 Countries in terms of Vaccines")
        end
        # Mortality commands
        if (cmp(user_response, "2") == 0)
            println("Type '1' Mortality Across All 3 Years (2020, 2021, 2022)")
            println("Type '2' Mortality Across All 3 Years")
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
        println(line)
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

main()