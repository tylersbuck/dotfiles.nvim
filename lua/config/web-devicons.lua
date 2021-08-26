local present, icons = pcall(require, 'nvim-web-devicons')
if not present then
  return
end

icons.setup {
  override = {
    ['default_icon'] = {
      icon = '',
      color = '#69676c',
      name = 'Default'
    };
    ['.bashrc'] = {
      icon = "",
      color = "#7bd88f",
      name = "Bashrc"
    };
    [".bashprofile"] = {
      icon = "",
      color = "#fbd88f",
      name = "BashProfile"
    };
    [".gitattributes"] = {
      icon = "",
      color = "#525053",
      name = "GitAttributes"
    };
    [".gitconfig"] = {
      icon = "",
      color = "#525053",
      name = "GitConfig"
    };
    [".gitignore"] = {
      icon = "",
      color = "#525053",
      name = "GitIgnore"
    };
    [".gitmodules"] = {
      icon = "",
      color = "#525053",
      name = "GitModules"
    };
    [".vimrc"] = {
      icon = "",
      color = "#7bd88f",
      name = "Vimrc"
    };
    ["_vimrc"] = {
      icon = "",
      color = "#7bd88f",
      name = "Vimrc",
    };
    ["bash"] = {
      icon = "",
      color = "#7bd88f",
      name = "Bash",
    };
    ["cmake"] = {
      icon = "",
      color = "#69676c",
      name = "CMake"
    };
    ["conf"] = {
      icon = "",
      color = "#69676c",
      name = "Conf",
    };
    ["diff"] = {
      icon = "",
      color = "#525053",
      name = "Diff",
    };
    ["dockerfile"] = {
      icon = "",
      color = "#363537",
      name = "Dockerfile",
    };
    ["Dockerfile"] = {
      icon = "",
      color = "#363537",
      name = "Dockerfile"
    };
    ["git"] = {
      icon = "",
      color = "#fd9353",
      name = "GitLogo"
    };
    ["go"] = {
      icon = "",
      color = "#5ad4e6",
      name = "Go",
    };
    ["ini"] = {
      icon = "",
      color = "#69676c",
      name = "Ini",
    };
    ["json"] = {
      icon = "",
      color = "#fce566",
      name = "Json",
    };
    ['lua'] = {
      icon = '',
      color = '#948ae3',
      name = 'Lua'
    };
    ["makefile"] = {
      icon = "",
      color = "#69676c",
      name = "Makefile",
    };
    ["markdown"] = {
      icon = "",
      color = "#5ad4e6",
      name = "Markdown",
    };
    ["md"] = {
      icon = "",
      color = "#5ad4e6",
      name = "Md",
    };
    ["node_modules"] = {
      icon = "",
      color = "#fc618d",
      name = "NodeModules",
    };
    ["sh"] = {
      icon = "",
      color = "#69676c",
      name = "Sh"
    };
    ["sln"] = {
      icon = "",
      color = "#948ae3",
      name = "Sln"
    };
    ["sql"] = {
      icon = "",
      color = "#bab6c0",
      name = "Sql"
    };
    ["terminal"] = {
      icon = "",
      color = "#7bd88f",
      name = "Terminal"
    };
    ['vim'] = {
      icon = "",
      color = "#7bd88f",
      name = "Vim"
    };
    ["yaml"] = {
      icon = "",
      color = "#5ad4e6",
      --color = "#69676c",
      name = "Yaml"
    };
    ["yml"] = {
      icon = "",
      color = "#5ad4e6",
      name = "Yml"
    };
  };
}
