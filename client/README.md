Please see parent directory [README.md](../README.md).

Building options
==========================
  1. Rails & React with hot reloading styleguide

  ```bash
  foreman start -f Procfile.hot
  ```
    > Currently runs all webpack configs options:
    > - webpack.client.config.js => .js & .css files to be imported in the Rails side
    > - webpack.server.config.js => server-bundle.js to be used if 'prerender: true'
    > - webpack.storybook.config.js => Hot reloading styleguide setup

  1. Rails & React
  ```bash
  foreman start -f Procfile.static
  ```
  > Currently runs build configs options
  > - webpack.client.config.js => .js & .css files to be imported in the Rails side
  > - webpack.server.config.js => server-bundle.js to be used if 'prerender: true'


  1. Creating Assets for Tests
  ```bash
  foreman start -f Procfile.spec
  ```
  > Currently runs build configs options
  > - webpack.client.config.js => .js & .css files to be imported in the Rails side
  > - webpack.server.config.js => server-bundle.js to be used if 'prerender: true'

If you need to debug the Rails parts of Sharetribe with [Pry](https://github.com/pry/pry), it's not possible with Foreman due to a [known compatibility issue](https://github.com/ddollar/foreman/pull/536). In this case we recommend running Rails with old-fashioned `rails server` and React builds with Foreman in a separate terminal. That way your `binding.pry` calls open nicely in the same window with the Rails process. Procfiles `Procfile.client-static` and `Procfile.client-hot` are configured for that, respective descriptions above apply.


Developing new components
==========================

You need to register new React components (e.g. "ExampleApp") for react_on_rails gem to recognize it.
```js
ReactOnRails.register({ ExampleApp });
```
Add it to _sharetribe/client/app/startup/clientRegistration.js_ and _serverRegistration.js_. Read more from [react_on_rails repository](https://github.com/shakacode/react_on_rails) and check [their example app](https://github.com/shakacode/react_on_rails/tree/master/spec/dummy).

New React components can be included to HAML and ERB files with '_react_component_':
```erb
<%= react_component("ExampleApp", props: @app_props_server_render, prerender: true, trace: true) %>
```

_webpack.server.rails.build.config.js_ creates a _server-bundle.js_ file which is used by react_on_rails gem to create server-side rendering.

_webpack.client.rails.build.config.js_ defines how component specific styles are extracted using ExtractTextPlugin (if you have imported style.css file in your React component). These generated files (_app-bundle.js_, _vendor-bundle.js_, and _app-bundle.css_) and they are saved to _sharetribe/app/assets/webpack_ folder.

We are using [CSS Modules](https://github.com/css-modules/css-modules) and preprocessors like SASS-loader and [PostCSS](https://github.com/postcss/postcss) loader.
**N.B. we are likely to remove SASS loader quite soon and configure PostCSS better.**

We use [React Storybook](https://github.com/kadirahq/react-storybook) for a hot reloading component development environment, in `http://localhost:9001/`. See [instructions for writing stories](https://github.com/kadirahq/react-storybook#writing-stories), for example story see [OnboardingTopBar.story.js](app/components/OnboardingTopBar/OnboardingTopBar.story.js).

ESLint
==========================
The `.eslintrc` file is based on the AirBnb [eslintrc](https://github.com/airbnb/javascript/blob/master/linters/.eslintrc).

It also includes many eslint defaults that the AirBnb eslint does not include.

You can run the linting with:

    npm run lint
