require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
    it 'should switch all tasks complete status to true' do
      list = List.create
      2.times do
        Task.create(complete: false, list_id: list.id)
      end
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end  

  describe '#snooze_all_tasks!' do
    it 'should add one hour to each deadlines' do
      list = List.create
      times = [Time.now, 1.hour.from_now, 3.hours.ago] 

      times.each do |time|
        Task.create(list_id: list.id, deadline: time)
      end

      list.snooze_all_tasks!

      list.tasks.each_with_index do |task, index|
        expect(task.deadline).to eq(times[index] + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should return the sum of all task durations' do
      list = List.create
      [50, 100, 200].each do |duration_mark|
        Task.create(list_id: list.id, duration: duration_mark)
      end
      expect(list.total_duration).to eq(350)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all incomplete tasks for a list' do
      list = List.create
      Task.create(
                  name: "take out papers",
                  complete: true,
                  list_id: list.id
                  )
      Task.create(
                  name: "take out trash",
                  complete: false,
                  list_id: list.id
                  )
      Task.create(
                  name: "spend some spending cash",
                  complete: false,
                  list_id: list.id
                  )
      Task.create(
                  name: "mow lawn",
                  complete: true,
                  list_id: list.id
                  )
      incomplete_task_objects = list.incomplete_tasks
      expect(list.incomplete_tasks.length).to eq(2)
      incomplete_task_objects.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of all favorite tasks for a list' do
      list = List.create
      Task.create(
                  name: "take out papers",
                  favorite: true,
                  list_id: list.id
                  )
      Task.create(
                  name: "take out trash",
                  favorite: true,
                  list_id: list.id
                  )
      Task.create(
                  name: "spend some spending cash",
                  favorite: false,
                  list_id: list.id
                  )
      Task.create(
                  name: "mow lawn",
                  favorite: true,
                  list_id: list.id
                  )
      favorite_task_objects = list.favorite_tasks
      expect(list.favorite_tasks.length).to eq(3)
      favorite_task_objects.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end








end













