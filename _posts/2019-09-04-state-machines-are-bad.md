---
title: State machines are bad
description: ' In this short article I would like to show how to remove them altogether and follow SOLID principles of OOP.'
slug: state-machines-are-bad
layout: post
date: '2019-09-04 09:44:25 +0200'
category: Ruby on Rails development
author: Michał Kosyk
authors: Michał Kosyk
avatar: /assets/images/michal_kosyk_profile.png
image: /assets/images/stick-it_-and-the-power-of-event-storming-1-.png
text-preview: >-
  This is a loaded topic. Some would say that it is a matter of opinion, context
  and so on. Some would say that it is the right approach. I, on the other hand,
  deeply believe that using state machines in your code is just a form of lazy
  programming. In this short article I would like to show how to remove them
  altogether and follow SOLID principles of OOP.
tags:
  - Ruby on Rails development
  - state machines
---
This is a loaded topic. Some would say that it is a matter of opinion, context and so on. Some would say that it is the right approach. I, on the other hand, deeply believe that using state machines in your code is just a form of lazy programming. In this short article I would like to show how to remove them altogether and follow SOLID principles of OOP.

## Why do you even need state?

That’s a good question but fear no longer! Bear with me, for I know the answer! Imagine you have a car. It is in perfect shape. Let us visualise a really messy accident. Miraculously, nothing happened to you but your super nice (and expensive) Porsche Carrera GT is wrecked (to put it kindly). It is still a car but in a different state, right?

Wrong! Right now it’s just a wreck! A sorry piece of metal, mangled and clumped together with glass, plastic and some electronics. Now, would you rather define it as:

```ruby
car = Car.new(state: ‘wreck’)
```

or

```ruby
car_wreck = CarWreck.new
```

Which one is **easier to understand**?

## But where is the problem?

Another good question! Let’s define what the _state of an object_ is. States are a way to provide us information about what properties an object has. A state in itself is completely ok if not overused by programmers. It’s just not that useful. If you have a data source, why do you need states in your application? Your database is a big collection of states for different entities. By now, you’ll probably disagree, but bear with me. Let me provide an example:

```ruby
class Human < ActiveRecord::Base
   STATES = ["living", "dead"]
   AGES = ["infant", "child", "teenager", "adult", "elder"]
 end
```

Most of the times, this will be translated into:

```ruby
class Human < ActiveRecord::Base 
  STATES = ["living", "dead"]
   AGES = ["infant", "child", "teenager", "adult", "elder"] 
```

Now, what typically happens is the programmer starts using it all over the place. The state of one class becomes the state of the whole app. It will end up in views:

```ruby
<% if human.dead? && human.teanager? %> 
  <p>DEAD TEENAGER</p>
 <% else %> 
  <p>Lives</p> 
<% end %>
```

and in your services:

```ruby
class SendEmail 
  def call(human)
     return if human.dead? || human.infant? || human.child?

      # logic
   end

    # some logic 
end
```

## But can we do any better?

Yes, we can! And it’s a matter of rethinking the abstraction. The worst habit to have is to do the _easiest_ thing, rather than going the extra mile to do what’s _harder_ but still _simple_. How about we write classes for every single state we have? Even those that we don’t consider states but know to be different for different objects. It’s all a matter of encapsulating the real core of the given idea. We need to put the hard work in now if we want to reap the benefits later.

Let’s begin. First, remove the state machine from your ActiveRecord model:

```ruby
class Human < ActiveRecord::Base 
  STATES = ["living", "dead"]
   AGES = ["infant", "child", "teenager", "adult", "elder"]
 end
```

Then, there is a problem. A **Human** can have two general states and a few specific ones. We cannot just create a _factory_. We need to create an _abstract factory_ which returns the right abstraction for creating the different states of a **Human**.

```ruby
class HumanAbstractFactory
  def initialize(dead_human_factory: DeadHumanFactory.new,
                 living_human_factory: LivingHumanFactory.new)
    @dead_human_factory = dead_human_factory
    @living_human_factory = living_humang_factory
  end

  def build(human)
    if human.dead?
      dead_human_factory.build(human)
    else
      living_human_factory.build(human)
    end
  end

  private

  attr_reader :dead_human_factory, :living_human_factory
end
```

Okay, we are dealing with two injected dependencies. We need to build them.

```ruby
class DeadHumanFactory
  def build(human)
    case human.state
    when "infant"
      DeadInfantHuman.new(human)
    when "child"
      DeadChildHuman.new(human)
    when "teenager"
      DeadTeenagerHuman.new(human)
    else
      DeadHuman.new(human)
    end
  end
end
```

The living have their own little classes:

```ruby
class LivingHumanFactory
  def build(human)
    case human.state
    when "infant"
      InfantHuman.new(human)
    when "child"
      ChildHuman.new(human)
    when "teenager"
      TeenagerHuman.new(human)
    when "adult"
      AdultHuman.new(human)
    else
      ElderHuman.new(human)
    end
  end
end
```

Now, we have all these new classes. The most appropriate pattern here is the _Decorator_. It allows to extend functionalities of our objects by wrapping them with other objects with additional methods. So, let’s look at one of the classes:

```ruby
class DeadTeenager
  def initialize(human)
    @human = human
  end

  def epitaph_title
    "DEAD TEENAGER"
  end

  def emailable?
    true
  end

  # other methods
end
```

Interesting, isn’t it? We have some hard-coded stuff. It feels dirty but it isn’t. In reality, you would use an **I18n** library. What are the consequences of _the refactor of our idea_? Simpler views and services. The view looks like this:

```ruby
<p> <%= human.epitaph_title %></p>
```

And the service looks like this:

```ruby
class SendEmail
  def call(human)
    return unless human.emailable?

    # logic
  end

  # some logic
end
```

## But that’s more code!

Yes, but you don’t have to analyse the code so often. Are you still unconvinced? Let’s add a little twist. We need to add another age and state: “young adult” and “sick”:

```ruby
class Human < ActiveRecord::Base
  STATES = ["living", "dead", "sick"]
  AGES = ["infant", "child", "teenager", "young adult", "adult", "elder"]
end
```

The requirement is: every sick young adult should have the epitaph title “Sick and young”. Likewise, every other sick Human should have the epitaph title “sick”. So we have a problem: How should we go about it? There are a few ways of addressing this issue. I would personally go for creating a new Young Adult class and putting it in the LivingHumanFactory:

```ruby
class YoungAdult
  def initialize(human)
    @human = human
  end

  def epitaph_title
    return "Sick and young" if @human.sick?

    "Living"
  end

  def emailable?
    true
  end

  # other methods
end
```

And the factory:

```ruby
class LivingHumanFactory
  def build(human)
    case human.state
    when "infant"
      InfantHuman.new(human)
    when "child"
      ChildHuman.new(human)
    when "teenager"
      TeenagerHuman.new(human)
    when "young adult"
      YoungAdultHuman.new(human)
    when "adult"
      AdultHuman.new(human)
    else
      ElderHuman.new(human)
    end
  end
end
```

You could even try to go for some nice ruby tricks:

```ruby
class LivingHumanFactory
  def build(human)
    human_state = human.state
    human_class = 
      "#{human_state.tr(' ', '_').camelize}Human".constantize
    human_class.new(human)
  end
end
```

You can move _\#camelize_ method into the Human class. But for now it’s a bit out of topic.

With all of the above, you can make your business logic purely abstract, without polluting it with nasty concretisation.



## Final thoughts



I would like to apologise for this article’s general tone. It stems from my frustration with another project riddled with conditional statements that could have been easily avoided. The more “_ifs_” you remove from the code, the easier it becomes to create a coherent theory of the thing you’re working on. Exception does not make the rule. It breaks it, for every theory should encompass those exceptions in it.



Remove “ifs”, have a better development cycle. You owe it to yourself and those calling your code legacy.



Farewell
