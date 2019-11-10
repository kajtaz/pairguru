class TitleBracketsValidator < ActiveModel::Validator


  def validate(record)
    stack  = []
    lookup = { '(' => ')', '[' => ']', '{' => '}'}
    left   = lookup.keys
    right  = lookup.values

    record.title.each_char do |char|
      if left.include? char
        stack << char
      elsif right.include? char
        return false if stack.empty? || (lookup[stack.pop] != char)

      end
    end

    return record.errors.add(:title, "bracket unclosed") unless stack.empty?
  end
end
