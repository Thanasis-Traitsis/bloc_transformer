# Flutter Bloc Transformer Events
![Header](https://github.com/Thanasis-Traitsis/bloc_transformer/blob/main/assets/article/Flutter%20Bloc%20Transformer%20Events.png?raw=true)
Hey there, Flutter devs! I see you. You've been crafting that new feature, but something feels... off. You know you got the logic right, it's pretty clear in that well-structured code you wrote. Yet somehow, your Bloc events seem to have a mind of their own. Why aren't they behaving the way you know they should?

Don't worry—you're not alone. Today, we're diving into Bloc transformer events. What if I told you that in every Bloc event you build, there is a transformer running behind the scene. And what If I take it a step further and tell you that there are not one but FOUR transformers you can choose from. These little operators can drastically shape how your events are processed, and trust me, they can make or break your flow.

So, it's time for another debugging adventure. Jump back to your code and let's solve the mystery of transformer events. By the end, you'll wonder how you ever lived without them.

## Types of Transformer Events

- **concurrent:** When you create a Bloc and start creating events, concurrent is the transformer working behind the scenes. This is the default behavior of Bloc. It's a pretty standard way of executing the code and a really convenient one. Every event operate independently, without affecting the behavior of others.
<br><br>
Think of concurrent events like customers at a café. One customer orders a coffee and enjoys it at their own pace. While enjoying their coffee, another customer places an order without waiting for the first to finish. We can all enjoy our coffee with no problem.
<br><br>
In Bloc terms:
- Multiple events can be processed simultaneously without waiting for the previous one to complete.
- Events aren’t bottlenecked—each one is handled as soon as it arrives.

[[[[ FIRST BANNER]]]]

But wait, what if the café has only one chair? Suddenly, things aren’t so smooth. Now, each customer has to wait for the previous one to finish their coffee before placing an order.

- **sequential:** Events are carried out exactly as they come in thanks to the sequential transformer, but only one at a time. A new event cannot start until the processing of the prior one is complete.
<br><br>
Imagine a tiny espresso bar with just one chair and a single barista. One customer orders, sits, drinks their coffee, and only then can the next customer step up. 
<br><br>
In Bloc:
- Events queue up and are processed sequentially.
- No two events overlap, ensuring a predictable and orderly flow.

[[[[ SECOND BANNER]]]]

Okay now that we get the first two transformers out of the way, it’s time to introduce something that’s a total game-changer—especially for search and autocomplete features.

- **restartable:** This event is perfect for situations where only the latest event matters. When a new event arrives, it cancels any ongoing ones and immediately starts processing the fresh request.
<br><br>
Last 
Now, I want you to imagine that you decide to drink your coffee in the worst café of all time. You sit down, peacefully sipping your hot coffee, enjoying life. Then a new customer appears out of nowhere! Without hesitation, they snatch your cup, kick you out, and start drinking their own coffee.
<br><br>
In Bloc:
- If multiple search queries are fired rapidly, only the latest one gets processed.
- Any previous events still in progress are cancelled as soon as a new one arrives.

For real-time search, form validation, or any situation where the most recent input is prioritised, this transformer is your best option. Restartable is the best option if the most recent modification is all that matters.

[[[[ THIRD BANNER]]]]

Last but not least, the final transformer event is a really interesting one. Let's talk about the droppable event.

- **droppable:** This event is really useful when you want to avoid repetitive calls. If an event is already being processed, any new events of the same type are ignored until the first one finishes. Once the running event completes, the next one can be accepted.
<br><br>
Let’s visit one last café. You walk in, eager for a cup of coffee and you see another person already enjoying their drink. You sit down and start waving to place your order, but no one listens. The staff won’t take your order until the current customer finishes and leaves. Once that last drop is gone, the café is all yours, and the waiters rush to take your order.\
<br><br>
In Bloc:
- If an event (like fetching data) is already running, new incoming events are ignored.
- Once the active event completes, the next event will be accepted.

That's a really useful tools for situations like API calls that shouldn't be interrupted, or maybe for preventing duplicate submissions.

[[[[ FOURTH BANNER]]]]

## Package & Code

All it takes to unlock this feature is installing a package and writing just ONE line of code. Really, that's all! The rest? Just your regular Bloc setup, nothing special.

First, download this package:
- [bloc_concurrency](https://pub.dev/packages/bloc_concurrency) : With this package we are able to use all of the transformer events with built in functions.

Now, all you have to do, is jump in the `example_bloc.dart` file, and change the way you initialize a bloc event. For example, I have a simple counter application, in which I manage the state with a Bloc event.

``` dart
  TransformerBloc() : super(const TransformerState(count: 0)) {
    on<IncrementPressed>(
      _onIncrement, // By default, it has the concurrent transformer
    );
  }
  
  Future<void> _onIncrement(
      IncrementPressed event, Emitter<TransformerState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(count: state.count + 1));
  }
```

If want to change the way I handle this event, by applying sequential transformer for example, all I have to do is this:
``` dart
  TransformerBloc() : super(const TransformerState(count: 0)) {
    on<IncrementPressed>(
      _onIncrement,
      transformer: sequential(), // Apply this line
    );
  }
```

## Conclusion

Bloc transformer events might look like a hidden detail at first, but as you can see they can take your state management in a whole new level. And the best part? You only need to add one line in your existing code, and change the entire functionality. How amazing is that?

Now go on my Flutter friends, you are free to explore new code adventures. Next time your Bloc events aren’t behaving quite the way you expected, remember—you’ve got options. Pick the right transformer, like you pick the right café in your hometown that serves the best coffee. 😉 ☕
