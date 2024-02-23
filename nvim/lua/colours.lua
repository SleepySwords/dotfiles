local M = {}

function M.name_to_tuple(colour)
    return {
        red = bit.band(bit.rshift(colour, 16), 0xFF),
        green = bit.band(bit.rshift(colour, 8), 0xFF),
        blue = bit.band(colour, 0xFF),
    }
end

function M.get_colour_tuple(name, item)
    return M.name_to_tuple(vim.api.nvim_get_hl(0, { name = name, link = false})[item])
end

function M.tint(colour, factor)
    return {
        red = colour.red + ((255 - colour.red) * factor),
        green = colour.green + ((255 - colour.green) * factor),
        blue = colour.blue + ((255 - colour.blue) * factor),
    }
end

function M.shade(colour, factor)
    return {
        red = colour.red * factor,
        green = colour.green * factor,
        blue = colour.blue * factor,
    }
end

function M.lightness(colour)
    local max = math.max(colour.red, colour.green, colour.blue) / 255
    local min = math.min(colour.red, colour.green, colour.blue) / 255
    return (max + min) / 2
end

function M.tuple_to_hex(colour)
    return '#'
        .. ('%02x'):format(math.abs(colour.red))
        .. ('%02x'):format(math.abs(colour.green))
        .. ('%02x'):format(math.abs(colour.blue))
end

function M.contrast(colour, factor)
    if M.lightness(colour) > 0.5 then
        return M.shade(colour, factor)
    else
        return M.tint(colour, 1 - factor)
    end
end

function M.contrast_based_on(colour, factor, light)
    if not light then
        return M.shade(colour, factor)
    else
        return M.tint(colour, 1 - factor)
    end
end

return M
