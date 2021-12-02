module ComputerPlayer
  def new_answer
    num = []
    4.times do
      num << rand(1..6)
    end
    return num.join()
  
  end

  def computer_guess
    num = []
    4.times do
      num << rand(1..6).to_s
    end
    return num  
  end
end