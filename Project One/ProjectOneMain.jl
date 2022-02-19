function main()
    # title sequence
    user_response = ""

    while user_response != "quit"
        # list of commands:
        print("Please Type a Command: ")
        print("Type '1' for Vaccination Records")

        user_response = readline()
        if (user_response == "1")
            VaccineDict = vaccinations()
        end
        println(user_response)
    end

end

function vaccinations()
    file = open("")
    
end 

main()