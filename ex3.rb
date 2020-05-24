class Person

    def initialize(name,cpf,telephone,age)
        @name = name
        @cpf = cpf
        @telephone = telephone
        @age = age
    end
end

class CheckingAccount < Person

    @@checkingaccounts = []

    attr_reader :checkingaccounts, :name, :cpf, :age, :telephone, :accnumber, :password, :balance
    attr_writer :telephone
 
    def initialize(name,cpf,telephone,age,balance,accnumber,password)
        super(name,cpf,telephone,age)
        @balance = balance
        @accnumber = accnumber
        @password = password
        @@checkingaccounts << self
    end

    def self.accounts
        return @@checkingaccounts
    end

    def addMoney(amount)
        @balance = @balance.to_i + amount 
        return {new_balance: @balance, amount_added: amount}
    end

    def takeMoney(amount)
        @balance = @balance.to_i - amount
        return {new_balance: @balance, amount_taken: amount}
    end

end

class SavingsAccount < Person

    @@savingsaccounts = []

    attr_reader :savingsaccounts, :name, :cpf, :age, :telephone, :accnumber, :password, :savings
    attr_writer :telephone

    def initialize(name,cpf,telephone,age,savings,accnumber,password)
        super(name,cpf,telephone,age)
        @savings = savings
        @accnumber = accnumber
        @password = password
        @@savingsaccounts << self
    end

    def self.accounts
        return @@savingsaccounts
    end

    def addMoney(amount)
        @savings = @savings.to_i + amount 
        return {new_savings: @savings, amount_added: amount}
    end
    
    def takeMoney(amount)
        @savings = @savings.to_i - amount
        return {new_savings: @savings, amount_taken: amount}
    end

end

def accountmenu(account)

    loop do

    puts "\nChoose an option:"
    puts "{1} Deposit"
    puts "{2} Withdraw"
    puts "{3} Show Balance"
    puts "{4} Change Telephone"
    puts "{5} Display Personal Data"
    puts "{6} Display Account Data"
    puts "{7} Quit\n"

    op = gets.to_i

        case op
        when 1
            puts "How much would you like to deposit? A: "
            depositvalue = gets.to_i
            if depositvalue > 0
                account.addMoney(depositvalue)
                puts "\nYou have succesfully deposited #{depositvalue}$ and now own #{account.balance}$."
            else
                puts "\nInvalid amount."
            end
            
        when 2
            puts "\nHow much would you like to withdraw? A: "
            withdrawvalue = gets.to_i
            if withdrawvalue <= account.balance.to_i
                account.takeMoney(withdrawvalue)
                puts "\nYou have succesfully withdrawn #{withdrawvalue}$ and now own #{account.balance}$."
            else
                puts "\nCan't withdraw #{withdrawvalue}$, for you only own #{account.balance}$. Try a smaller amount (or a loan).\n"
            end
            
        when 3
            puts "\nBalance: #{account.balance}$"
            
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

            if validcount == 9 && invalidcount == 0
                account.telephone = "#{newtelephone}"
                puts "You have successfully changed your telephone number."
            else
                puts "Invalid telephone number."
            end

        when 5
            puts "\nName: #{account.name}"
            puts "CPF: #{account.cpf}"
            puts "Telephone: #{account.telephone}"
            puts "Age: #{account.age}"

        when 6
            puts "\nBalance: #{account.balance}"
            puts "Account Number:#{account.accnumber}"
            puts "Account Password: #{account.password}"
        

        when 7
            puts "\nSo long!"
            break

        else
            puts "\nInvalid option."
        end
    end
end

def startingmenu

    puts "\nWelcome! Choose an option:"
    puts "{1} List Checking Accounts"
    puts "{2} List Savings Accounts"
    puts "{3} Create Checking Account"
    puts "{4} Create Savings Account"
    puts "{5} Log In"
    puts "{6} Quit\n"

    op = gets.to_i
    return op
end

loop do
    userchoice = startingmenu()
    case userchoice

    when 1
        puts "All Checking Accounts: "
        puts CheckingAccount.accounts.map { |account| "#{account.name}, #{account.accnumber}"}
        
    when 2
        puts "All Savings Accounts: "
        puts SavingsAccount.accounts.map { |account| "#{account.name}, #{account.accnumber}"}
    
    when 3
        puts "Creating new checking account..."
        puts "Please enter your name:"
        name = gets.chomp
        puts "Enter your CPF:"
        cpf = gets.chomp
        puts "Enter your telephone number:"
        telephone = gets.chomp
        puts "Enter your age:"
        age = gets.chomp
        puts "Enter your password:"
        password = 0
        loop do
            password = gets.chomp
            break if password.length >= 6
            puts "Invalid password. Remember to use at least 6 characters. Try again:"
        end

        accnumber = 0

        loop do
            accnumber = rand(1000..9999)
            break if CheckingAccount.accounts.select { |account| account.accnumber == accnumber}.empty?
        end

        balance = 0
        CheckingAccount.new(name,cpf,telephone,age,balance,accnumber,password)
        puts "Success! Your new checking account has been created."
        
    when 4
        puts "Creating new savings account..."
        puts "Please enter your name:"
        name = gets.chomp
        puts "Enter your CPF:"
        cpf = gets.chomp
        puts "Enter your telephone number:"
        telephone = gets.chomp
        puts "Enter your age:"
        age = gets.chomp
        puts "Enter your password. Please use at least 6 characters."
        loop do
            password = gets.chomp
            break if password.length >= 6
            puts "Invalid password; remember to use at least 6 characters. Try again:"
        end

        loop do
            accnumber = rand(1000..9999)
            break if SavingsAccount.accounts.select { |account| account.accnumber == accnumber}.empty?
        end

        savings = 0
        SavingsAccount.new(name,cpf,telephone,age,savings,accnumber,password)
        puts "Success! Your new savings account has been created."

    when 5
        puts "\nWould you like to log in to a Checking or a Savings Account?"
        puts "{1} Checking"
        puts "{2} Savings"
        acctype = gets.to_i

        loop do
            case acctype
            when 1
                if CheckingAccount.accounts.empty?
                    puts "There are no registred Checking Accounts yet."
                else
                    inputaccnumber = 0
                    loginacc = 0
                    loop do
                        puts "Please choose an account to log in by typing its Account Number.\n"
                        puts CheckingAccount.accounts.map { |account| "#{account.name}, #{account.accnumber}"}
                        inputaccnumber = gets.chomp
                        loginacc = CheckingAccount.accounts.select { |account| account.accnumber.to_s == inputaccnumber}.first
                        break if loginacc
                    end
                    loop do
                        puts "Please enter your password: "
                        inputpassword = gets.chomp
                        break if inputpassword == loginacc.password
                    end
                    puts "You have sucessfully logged in to Checking Account (#{inputaccnumber})."
                    accountmenu(loginacc)
                end

            when 2
                if SavingsAccount.accounts.empty?
                    puts "There are no registred Checking Accounts yet."
                else
                    inputaccnumber = 0
                    loginacc = 0
                    loop do
                        puts "Please choose an account to log in by typing its Account Number.\n"
                        puts SavingsAccount.accounts.map { |account| "#{account.name}, #{account.accnumber}"}
                        inputaccnumber = gets.chomp
                        loginacc = SavingsAccount.accounts.select { |account| account.accnumber.to_s == inputaccnumber}.first
                        break if loginacc
                    end
                    loop do
                        puts "Please enter your password: "
                        inputpassword = gets.chomp
                        break if inputpassword == loginacc.password
                    end
                    puts "You have sucessfully logged in to Checking Account (#{inputaccnumber})."
                    accountmenu(loginacc)
                end
            end
        end

    when 6
        puts "\nSo long!"
        break

    else
        puts "\nInvalid option."
    end
end