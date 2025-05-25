--!native
--!optimize 2

return function(): () -> number
	local t: number = 0
	return function(): number
		local new_t: number = os.clock()
		if t == 0 then t = new_t end
		local delta: number = new_t - t
		t = new_t
		return delta
	end
end
