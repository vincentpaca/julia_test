import Pkg; Pkg.add("DataStructures")
using DataStructures
using Test

function check_line(line)

  s = Stack{Char}()

  println("Line: ", line)

  opening_chars = ['(', '[', '<', '{']
  closing_chars = [')', ']', '>', '}']
  scores = [3, 57, 25137, 1197]

  score = 0

  for character in line
    # println("char is ", character)
    if character in opening_chars
        # println("Char is opening")
        push!(s, character)
    else
        # println("Char is closing")
        top_char_in_stack = first(s)
        closing_index = indexin(character, closing_chars)[1]
        opening_index = indexin(top_char_in_stack, opening_chars)[1]
        if closing_index == opening_index
            # println("Matches. Popping stack")
            pop!(s)
        else
            # print("Not ok")
            score = scores[closing_index]
            break
        end
    end
  end

  # println("Score: ", score)
  return score

end

function check_lines(lines)
    total_score = 0
    for line in lines
        total_score += check_line(line)
    end
    return total_score
end

@testset "Check Navigation" begin
  @test check_lines(readlines("input1.txt")) == 0
  @test check_lines(readlines("input2.txt")) == 0
  @test check_lines(readlines("input3.txt")) == 0
  @test check_lines(readlines("input4.txt")) == 26397
  @test check_lines(readlines("input5.txt")) == 25137
end