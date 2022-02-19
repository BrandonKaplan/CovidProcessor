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

main()