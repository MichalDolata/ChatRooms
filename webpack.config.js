const path = require('path');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const paths = {
    source: {
        client: './client/index.js',
    },
    dest: {
        path: path.resolve(__dirname, 'priv/static'),
        scripts: 'js/[name].bundle.js',
        styles: 'css/[name].css'
    }
};

const extractSass = new ExtractTextPlugin({
    filename: paths.dest.styles,
    disable: process.env.NODE_ENV === "development"
});

module.exports = {
    entry: paths.source,
    output: {
        path: paths.dest.path,
        filename: paths.dest.scripts
    },
    module: {
        noParse: /vendor\/phoenix/,
        rules: [
            {
                test: /\.(js|jsx)$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['react', 'es2015'],
                        plugins: ['transform-object-rest-spread']
                    }
                }
            },
            {
                test: /\.scss$/,
                use: extractSass.extract({
                    use: [{
                        loader: "css-loader"
                    }, {
                        loader: "sass-loader"
                    }],
                    // use style-loader in development
                    fallback: "style-loader"
                })
            }]
    },
    plugins: [
        extractSass
    ]
};