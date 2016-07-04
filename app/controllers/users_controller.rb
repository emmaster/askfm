class UsersController < ApplicationController
  def index
    @users = [
        User.new(
                id: 1,
                name: 'Vadim',
                username: 'installero',
                avatar_url: 'https://secure.gravatar.com/avatar/'
        ),
        User.new(
                id: 2,
                name: 'Misha',
                username: 'aristofun'
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Alexey',
      username: 'alexk',
      avatar_url: 'https://secure.gravatar.com/avatar/6e65b6a033fba99124c8285c012af0bf',
    )

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'Какие вопросы', created_at: Date.parse('24.03.2016'))
    ]

    @new_question = Question.new

  end
end
