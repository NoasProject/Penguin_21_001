class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @state = params[:state].to_i
    @limit = params[:limit].to_i

    @todos = Todo.all

    if @state > 0
      @todos = @todos.where(state: @state)
    end

    if @limit > 0
      @todos = @todos.limit(@limit)
    end

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)
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
    if (@state >= 3 && @state != 9)
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
    @todo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:group_id, :state, :title, :description)
    end
end
