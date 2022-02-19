function main()
    # title sequence
    user_response = ""

    while user_response != "quit"
        # list of commands:
        print("Please Type a Command: ")
        print("Type '1' for Vaccination Records")

        user_response = readline()
        println(user_response)
        if (cmp(user_response, "1") == 0)
            vaccinations()
        end
        println(user_response)
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
    file = open("vaccinations.csv", "r")
    for line in readlines(file)
        println(line)
    end
    close(file) 
end 

main()