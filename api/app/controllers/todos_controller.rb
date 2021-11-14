class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  before_action :set_todos, only: [:index]

  # GET /todos
  def index
    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)
    @todo[:user_id] = getUserId
    @todo[:state] = 1

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    @p = todo_params
    @state = @p[:state].to_i
    if (@state > 3 && @state != 9)
      @p.delete("state")
    end

    if @todo.update(@p)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    logger.debug(@todo);
    @todo.destroy
  end

  private
    def set_todos
      @state = params[:state].to_i
      @limit = params[:limit].to_i
      
      logger.debug("todo: user_id: #{getUserId}")
      @todos = Todo.all.where(user_id: getUserId)
  
      if @state > 0
        @todos = @todos.where(state: @state)
      end
  
      if @limit > 0
        @todos = @todos.limit(@limit)
      end
    end

    def set_todo
      @userId = getUserId
      logger.debug("todo:: id:#{params[:id]}, userId:#{@userId}");
      @todo = Todo.find_by(id: params[:id], user_id: @userId)
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:group_id, :state, :title, :description)
    end
end
