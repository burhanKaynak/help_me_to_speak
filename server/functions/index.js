const functions = require("firebase-functions");
const stripe = require("stripe")(functions.config().stripe.testkey);


const calculateOrderAmount = (items) => {
    prices = [];
    catalog =[
        {'id':'1','price':150.0},
        {'id':'2','price':100.0},
        {'id':'3','price':50.0},
        {'id':'4','price':25.0}
    ];

    items.forEach(item => {
        price = catalog.find(x=> x.id == item.id).price;
        prices.push(price);
    });

    return parseInt(prices.reduce((a,b)=> a+b)*100);
}


const generateResponse = function (intent){
switch (intent.status) {
    case 'requires_action':
        return {
            clientSecret: intent.clientSacret,
            requiresAction: true,
            status: intent.status
        };
    case 'requires_payment_method':
        return {
            'error': 'Your card was denied, please provvide a new payment method'
        };

          case 'succeeded':
            console.log('Payment Succeeded.');

        return {clientSecret: intent.clientSecret, status: intent.status};
 }
 return {
    error: 'Failed'
};
};
exports.StripePayEndPointMethodId = functions.https.onRequest(async (req,res)=>{
    const{peymentMethodId, items, currency, useStripeSdk,} =req.body;
    const orderAmount = 1000;

    try {
            if(peymentMethodId){
                //create a new paymentIntent
                const params ={
                    amount: orderAmount,
                    confirm:true,
                    confirmation_method:'manual',
                    currency:currency,
                    payment_method: peymentMethodId,
                    use_stripe_sdk: useStripeSdk
                };

                const intent = await stripe.paymentIntents.create(params);
                console.log('intent: '+intent);
                return res.send(generateResponse(intent));
            }
            return req.sendStatus(400);

    } catch (e) {
        res.send({error: e.message});
    }
});
exports.StripePayEndPointIntentId = functions.https.onRequest(async (req, res)=>{
    const{paymentIntentId} = req.body;
    
    try {
        if(paymentIntentId){
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (e) {
        return res.send({error: e.message});
    }
});


// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
