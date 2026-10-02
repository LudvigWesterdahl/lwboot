vim.cmd([[
  syn clear jsonKeyword
  syn region jsonKeyword matchgroup=jsonKeyQuote start=/"/ end=/"\ze[[:blank:]\r\n]*\:/ concealends contained
]])
