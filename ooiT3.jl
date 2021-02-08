using JuMP
using GLPK

model=Model(GLPK.Optimizer)

@variable(model, x[1:3]>=0)

@objective(model, Max, sum(x)-x[2])

@constraint(model, x[1]+x[2]<=3)
@constraint(model, x[2]+x[3]<=2)

optimize!(model)

value.(x)
