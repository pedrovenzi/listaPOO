class BankAccount

    @@accounts = []

    attr_reader :balance
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
        return {new_balance: @balance, amount_added: amount}
    end

    def takeMoney(amount)
        @balance = @balance.to_i - amount
        return {new_balance: @balance, amount_taken: amount}
    end

    def showBalance #Não fiz pelo attr_reader pra facilitar no ex2
        return @balance
    end

    def changeTelephone(newtelephone)
        @telephone = newtelephone
    end


    def displayPersonalData
        return {name: @name, CPF: @cpf, telephone: @telephone, age: @age}
        #Posso fazer vários puts pelo attr_reader, mas não sei qual forma é melhor...
    end

    def displayAccountData
        return {accnumber: @accnumber, password: @password}
        #Mesma pergunta!
    end

    account_0 = BankAccount.new("Pedro Venzi","333.222.999-44","55555-5555","18","380","38750427","de_GreenOwl20201")
    puts account_0.addMoney(75)
    puts account_0.takeMoney(50)
    puts account_0.showBalance
    puts account_0.changeTelephone = "11111-1111"
    puts account_0.displayPersonalData
    puts account_0.displayAccountData
    
end
