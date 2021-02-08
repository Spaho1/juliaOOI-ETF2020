using JuMP
using GLPK

function transport(C, S, P)
	model = Model(GLPK.Optimizer);
	@variable(model, trans[1:length(S), 1:length(P)] >= 0, Int)
	@objective(
		model,
		Min,
		sum(
			C[i, j] * trans[i, j]
			for i in 1:length(S), j in 1:length(P)
		)
	)
	@constraints(model, begin
		[i in 1:length(S)], sum(trans[i, :]) <= S[i];
		[j in 1:length(P)], sum(trans[:, j]) >= P[j];
	end)
	optimize!(model);
	return value.(trans), objective_value(model);
end

C1=[8 18 16 9 10;10 12 10 3 15;12 15 7 16 4];
S1=[90, 50, 80];
P1=[30, 50, 40, 70, 30];
X,V =transport(C1,S1,P1)
