-- cols.lua
-- Converts :::{.cols} divs to Typst #cols()[...][...] calls.
-- Each direct child div of .cols becomes one column argument.
-- Optional width attribute sets the ratio, e.g.
--   :::{.cols width="2fr,1fr"}

local function is_typst(format)
  return quarto.doc.is_format("typst")
end

function Div(el)
  if not el.classes:includes("cols") then
    return nil
  end
  if not is_typst() then
    -- Fall back to standard columns for other formats
    return nil
  end

  -- Collect child Div blocks as columns; non-Div blocks go into a leading column
  local columns = {}
  for _, block in ipairs(el.content) do
    if block.t == "Div" then
      table.insert(columns, block.content)
    end
  end

  -- Build ratio argument if provided
  local ratio_arg = ""
  local width = el.attributes["width"]
  if width then
    ratio_arg = "ratio: (" .. width .. "), "
  end

  -- Emit raw Typst open, then each column's content, then close
  local result = {}
  table.insert(result, pandoc.RawBlock("typst", "#cols(" .. ratio_arg .. ")["))
  for i, col_content in ipairs(columns) do
    for _, b in ipairs(col_content) do
      table.insert(result, b)
    end
    if i < #columns then
      table.insert(result, pandoc.RawBlock("typst", "]["))
    end
  end
  table.insert(result, pandoc.RawBlock("typst", "]"))

  return result
end
