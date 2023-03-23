const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey);


const generateResponse = function (intent) {
    switch (intent.satus) {
        case 'requires_action':
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.satus
            };

        case 'requires_payment_method':
            return {
                'error': 'Your card was denied, please provide a new payment method',
            };
        case 'succeeded':
            return {
                clientSecret: intent.clientSecret,
                status: intent.satus
            };


    }

};
const calculateOrderAmount = (items) => {
    prices = [];
    catalog = [
        { 'id': '0', 'price': 150 },
        { 'id': '1', 'price': 100 },
        { 'id': '2', 'price': 50 },
        { 'id': '3', 'price': 25 },
    ]

    items.forEach(element => {
        price = catalog.find(x => x.id == items.id).price;
        prices.push(price);
    });
    return parseInt(prices.reduce((a, b) => a + b) * 100);
};

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, items, currency, useStriperSdk } = req.body;
    const orderAmount = calculateOrderAmount(items);
    try {
        if (paymentMethodId) {
            const params = {
                amount: orderAmount,
                confirm: true,
                confirmation_method: 'manual',
                currency: currency,
                payment_method: paymentMethodId,
                use_stripe_sdk: useStriperSdk
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log(`intent: ${intent}`);
            return res.send(generateResponse(intent));

        }
        return res.sendStatus(400);
    } catch (error) {
        return res.send({ error: error.message });

    }
});

exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;
    try {
        if (paymentMethodId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (error) {
        return res.send({ error: error.message });

    }
});