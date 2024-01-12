local M = {}


function M.rgb_to_hsl(r, g, b)
	local norm_r = r / 255
	local norm_g = g / 255
	local norm_b = b / 255

	local max = math.max(norm_r, norm_g, norm_b)
	local min = math.min(norm_r, norm_g, norm_b)

	local lum_ran = max - min
	local lum_tot = max + min

	local lightness = lum_tot / 2

	local saturation = 0
	if lightness > 0.5 then
		saturation = lum_ran / (2 - lum_tot)
	else
		saturation = lum_ran / lum_tot
	end

	local hue = 0
	if max == min then
		hue = 0
	elseif max == norm_r then
		hue = (norm_g - norm_r) / lum_ran + (g < b and 6 or 0)
	elseif max == norm_g then
		hue = (norm_b - norm_r) / lum_ran + 2
	elseif max == norm_b then
		hue = (norm_r - norm_g) / lum_ran + 4
	end

	hue = hue / 6
	if hue < 0 then
		hue = hue + 1/6
	end

	return hue, saturation, lightness
end

function M.convert(c)
	return bit32.bor(c , 0xFF), bit32.bor(bit32.lshift(c, 8), 0xFF)
end


return M
