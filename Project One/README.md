AUTHORS: Brandon Kaplan and Edward Botterbusch
CLASS: CSC 372, Spring 2022
DESCRIPTION: The purpose of this program is to demonstrate the efficiency of Julia
by utlizing it's capabilities of large mathematical computations and big data sets
through computing various statistics based on data for COVID-19. This program uses 
two different csv files that contains between 82,000 to 125,000 different data lines
on vaccine data and hospitalization data. The user can explore either of these sets
or time the program on how long it takes to perform the computations. Within each of
the commands for the data, the user can get the statistic for group/country, get the
average for the datasets, get the top ten highest and lowest vaccinated/hospitalization.

HOW TO RUN: Run ProjectOneMain.jl with covid-hospitalizations.csv and vaccinations.csv
in the same directory and then follow the prompts from the program

FILES:
ProjectOneMain.jl - The main Julia program to be run that displays various data 
statistics about the COVID-19 pandemic 

covid-hospitalizations.csv - a csv file with all the data about hospitalizations around
the world

vaccinations.csv - csv file with all the data about groups and the amount of people
who are vaccinated per group

Test.java - a java program to compare the Julia runtimes against

CSC 372 Julia Project #1.pptx - powerpoint presentation on Julia