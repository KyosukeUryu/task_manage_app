# frozen_string_literal: true

module TasksHelper
  def label_searching
    @label_id = Label.pluck(:id)
    @label_name = Label.pluck(:name)
    @labels = []
    i = 0
    @label_id.count.times do
      @labels << [@label_name[i], @label_id[i]]
      i += 1
    end
    @labels
  end
end
