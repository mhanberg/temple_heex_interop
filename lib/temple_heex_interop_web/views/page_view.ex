defmodule TempleHeexInteropWeb.PageView do
  use TempleHeexInteropWeb, :view
  import Phoenix.LiveView.HTMLEngine, only: [component: 3, inner_block: 2]

  def heex_block(assigns) do
    ~H"""
    <.heex_component>
      I'm in the inner block of the <span class="font-bold text-orange-500">HEEx</span>
      component, being <span class="italic">rendered</span>
      from <span class="font-bold text-orange-500">HEEx</span>!!
      <:card :let={num}>
        I'm the first!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={num}>
        I'm the second!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={num}>
        I'm the third!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={num}>
        I'm the fourth!
        The num for this card is <%= num %>!
      </:card>
    </.heex_component>

    <.temple_component>
      I'm in the inner block of the <span class="font-bold text-emerald-500">Temple</span>
      component, being <span class="italic">rendered</span>
      from <span class="font-bold text-orange-500">HEEx</span>!!
      <:card :let={%{num: num}}>
        I'm the first!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={%{num: num}}>
        I'm the second!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={%{num: num}}>
        I'm the third!
        The num for this card is <%= num %>!
      </:card>
      <:card :let={%{num: num}}>
        I'm the fourth!
        The num for this card is <%= num %>!
      </:card>
    </.temple_component>
    """
  end

  def temple_block(assigns) do
    temple do
      c &heex_component/1 do
        "I'm in the inner block of the "
        span class: "font-bold text-orange-500", do: "HEEx"
        "component, being "
        span class: "italic", do: "rendered"
        "from "
        span class: "font-bold text-emerald-500", do: "Temple!!"

        slot :card, num do
          "I'm the first!"
          "The num for this card is #{num}!"
        end

        slot :card, num do
          "I'm the second!"
          "The num for this card is #{num}!"
        end

        slot :card, num do
          "I'm the third!"
          "The num for this card is #{num}!"
        end

        slot :card, num do
          "I'm the fourth!"
          "The num for this card is #{num}!"
        end
      end

      c &temple_component/1 do
        "I'm in the inner block of the "
        span class: "font-bold text-emerald-500", do: "Temple"
        "component, being "
        span class: "italic", do: "rendered"
        "from "
        span class: "font-bold text-emerald-500", do: "Temple!!"

        slot :card, %{num: num} do
          "I'm the first!"
          "The num for this card is #{num}!"
        end

        slot :card, %{num: num} do
          "I'm the second!"
          "The num for this card is #{num}!"
        end

        slot :card, %{num: num} do
          "I'm the third!"
          "The num for this card is #{num}!"
        end

        slot :card, %{num: num} do
          "I'm the fourth!"
          "The num for this card is #{num}!"
        end
      end
    end
  end

  def heex_component(assigns) do
    ~H"""
    <div class="border-2 border-orange-500 rounded m-2 p-2">
      <%= render_slot(@inner_block, %{}) %>

      <ul class="list-disc pl-6">
        <%= for c <- @card do %>
          <li>
            <%= render_slot(c, Enum.random(0..100)) %>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end

  def temple_component(assigns) do
    temple do
      div class: "border-2 border-emerald-500 rounded m-2 p-2" do
        slot @inner_block

        ul class: "list-disc pl-6" do
          for c <- @card do
            li do
              slot c, %{num: Enum.random(0..100)}
            end
          end
        end
      end
    end
  end
end
