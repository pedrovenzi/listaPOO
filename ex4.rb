class Turma

    @@turmas = []
    
    attr_reader :alunos, :materia

    def initialize(materia,numeroalunos)
        @materia = materia
        #@alunos = {} -- Alunos passa a ser um array:
        @alunos = []
        cont = 0
        loop do
            num_matricula = rand(1000..9999)
            num_nota = rand(0..10.0)
            ##@alunos[matricula.to_sym] = nota -- Facilitou muito!
            @alunos << {:matricula => num_matricula, :nota => num_nota}
            cont += 1
            break if cont == numeroalunos
        end
        @@turmas << self
    end

    def self.turmas
        return @@turmas
    end

    def totalAlunos
        return @alunos.length
    end

    def alunosAprovados
        alunosaprovados = []
        for aluno in @alunos
            case
            when aluno[:nota] >= 5
                alunosaprovados.push(aluno[:matricula])
            end
        end     
        return alunosaprovados.length  
    end

end

puts "Quantas turmas? (Digite número entre 1 e 10)"
numeroturmas = 0
hash = {}

loop do
    numeroturmas = gets.to_i
    break if numeroturmas >= 1 && numeroturmas <= 10
    puts "Número inválido."
end

materias = ["Cálculo 1", "Cálculo 2", "Cálculo 3", "Física 1", "Física 2", "Estruturas de Dados", "Algoritmos e Programação de Computadores", "Técnicas de Programação 1", "Sistemas Digitais", "Eletromagnetismo"]
num_aprovados = 0
num_total = 0

for materia in 1..numeroturmas
    numeroalunos  = rand(5..20)
    turma = Turma.new(materias.sample.to_sym,numeroalunos)
    if hash.key?(turma.materia) #Matéria Repetida
        hash[turma.materia][:aprovados] += turma.alunosAprovados
        hash[turma.materia][:total] += turma.totalAlunos
    else #Matéria Nova
        hash[turma.materia] = {:aprovados => turma.alunosAprovados, :total => turma.totalAlunos}
    end
    num_aprovados += turma.alunosAprovados
    num_total += turma.totalAlunos
end

hash[:Total] = {:aprovados => num_aprovados, :total => num_total}

#30 minutos pra entender e fazer funcionar, porém finalmente consegui. Obrigado demais pela ajuda!
puts hash.map{ |materia, info| "#{materia}: #{((info[:aprovados].to_f / info[:total]) * 100).round(2)}% aprovados" }