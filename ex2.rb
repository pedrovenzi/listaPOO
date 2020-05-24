class BankAccount

    @@accounts = []

    attr_reader :name, :cpf, :telephone, :age, :balance, :accnumber, :password
    attr_writer :telephone
 
    def initialize(name,cpf,telephone,age,balance,accnumber,password)
        @name = name
        @cpf = cpf
        @telephone = telephone
        @age = age
        @balance = balance
        @accnumber = accnumber
        @password = password
        @@accounts << self
    end

    def addMoney(amount)
        @balance = @balance.to_i + amount 
        return @balance
    end

    def takeMoney(amount)
        @balance = @balance.to_i - amount
        return @balance
    end
end

account_0 = BankAccount.new("Pedro Venzi","333.222.999-44","555555555","18","5000","38750427","de_GreenOwl20201")

def menu

    puts "\nChoose an option:"
    puts "{1} Deposit"
    puts "{2} Withdraw"
    puts "{3} Show Balance"
    puts "{4} Change Telephone"
    puts "{5} Display Personal Data"
    puts "{6} Display Account Data"
    puts "{7} Quit\n"

    op = gets.to_i
    return op
end

loop do
    userchoice = menu()
    case userchoice

    when 1
        puts "How much would you like to deposit? A: "
        depositvalue = gets.to_i
        if depositvalue > 0
            account_0.addMoney(depositvalue)
            puts "\nYou have succesfully deposited #{depositvalue}$ and now own #{account_0.balance}$."
        else
            puts "\nInvalid amount."
        end
        
    when 2
        puts "\nHow much would you like to withdraw? A: "
        withdrawvalue = gets.to_i
        if withdrawvalue <= account_0.balance.to_i
            account_0.takeMoney(withdrawvalue)
            puts "\nYou have succesfully withdrawn #{withdrawvalue}$ and now own #{account_0.balance}$."
        else
            puts "\nCan't withdraw #{withdrawvalue}$, for you only own #{account_0.balance}$. Try a smaller amount (or a loan).\n"
        end
        
    when 3
        puts "\nBalance: #{account_0.balance}$"
        
    when 4
        puts "What is your new telephone? Please use only 9 digits. A: "
        newtelephone = gets.chomp
        telephonedec = newtelephone.bytes
        validcount = 0
        invalidcount = 0

        for dec in telephonedec
            case dec 
            when 48..57
                validcount += 1
            else
                invalidcount += 1
            end
        end

        if validcount == 9 && invalidcount != 0
            account_0.telephone = "#{newtelephone}"
            puts "You have successfully changed your telephone number."
        else
            puts "Invalid telephone number."
        end

    when 5
        puts "\nName: #{account_0.name}"
        puts "CPF: #{account_0.cpf}"
        puts "Telephone: #{account_0.telephone}"
        puts "Age: #{account_0.age}"

    when 6
        puts "\nBalance: #{account_0.balance}"
        puts "Account Number:#{account_0.accnumber}"
        puts "Account Password: #{account_0.password}"
      

    when 7
        puts "\nSo long!"
        break

    else
        puts "\nInvalid option."
    end
end