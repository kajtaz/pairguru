class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    valid = true
    brackets = { '{' => '}', '(' => ')', '[' => ']' }
    brackets_stack = []


    record.title.each_char.with_index do |a, b|
      brackets_stack << [brackets[a], b] if brackets.key?(a)

      if brackets.value?(a)
        last_bracket = brackets_stack.pop
        if last_bracket.nil? || last_bracket[0] != a || last_bracket[1] + 1 == b
          valid = false
          break
        end
      end
    end

    record.errors.add(:title, 'bracket unclosed') unless brackets_stack.empty? && valid
  end
end
