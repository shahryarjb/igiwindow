defmodule Mix.Tasks.Mishka.Ui.Gen.Component do
  use Igniter.Mix.Task
  @example "mix mishka.ui.gen.component component --example arg"

  def info(_argv, _composing_task) do
    %Igniter.Mix.Task.Info{
      # dependencies to add
      adds_deps: [],
      # dependencies to add and call their associated installers, if they exist
      installs: [],
      # An example invocation
      example: @example,
      # Accept additional arguments that are not in your schema
      # Does not guarantee that, when composed, the only options you get are the ones you define
      extra_args?: false,
      # A list of environments that this should be installed in, only relevant if this is an installer.
      only: nil,
      # a list of positional arguments, i.e `[:file]`
      positional: [:component],
      # Other tasks your task composes using `Igniter.compose_task`, passing in the CLI argv
      # This ensures your option schema includes options from nested tasks
      composes: [],
      # `OptionParser` schema
      schema: [
        variant: :string,
        color: :string,
        size: :string,
        module: :string,
        padding: :string,
        space: :string,
        type: :string,
        rounded: :string
      ],
      # CLI aliases
      aliases: [
        v: :variant,
        c: :color,
        s: :size,
        m: :module,
        p: :padding,
        sp: :space,
        t: :type,
        r: :rounded
      ]
    }
  end

  def igniter(igniter, argv) do
    # extract positional arguments according to `positional` above
    {%{component: component}, argv} = positional_args!(argv)

    options = options!(argv)
    IO.inspect(options, label: "=-==-=-=-=>")

    template_path =
      Application.app_dir(:igiwindow, ["priv", "components"])
      |> Path.join("#{component}.eex")

    web_module = "#{Igniter.Project.Application.app_name(igniter)}" <> "_web"
    proper_location = "lib/#{web_module}/components/#{component}.ex"
    component = atom_to_module(web_module <> ".components.#{String.to_atom(component)}")

    new_assign = [
      module: component,
      color: convert_option(options[:color]),
      size: convert_option(options[:size]),
      padding: convert_option(options[:padding]),
      space: convert_option(options[:space]),
      type: convert_option(options[:type]),
      rounded: convert_option(options[:rounded]),
      variant: convert_option(options[:variant])
    ]

    igniter
    |> Igniter.copy_template(template_path, proper_location, new_assign, on_exists: :overwrite)
  end

  def convert_option(nil), do: nil

  def convert_option(value),
    do: String.trim(value) |> String.split(",") |> Enum.map(&String.trim/1)

  def atom_to_module(field) do
    field
    |> String.split(".", trim: true)
    |> Enum.map(&Macro.camelize/1)
    |> Enum.join(".")
    |> String.to_atom()
  end
end
