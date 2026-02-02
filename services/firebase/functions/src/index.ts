import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

/**
 * recordCheckIn
 * - Called by client when user taps "I'm OK"
 * - Writes append-only check-in record
 * - Updates user streak counters
 */
export const recordCheckIn = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "Sign-in required");
  const uid = context.auth.uid;

  const now = admin.firestore.Timestamp.now();
  const checkinRef = admin.firestore().collection("checkins").doc();
  await checkinRef.set({
    uid,
    ts: now,
    source: "tap",
  });

  // TODO: implement streak logic based on last check-in day
  await admin.firestore().collection("events").add({
    type: "checkin",
    uid,
    ts: now,
  });

  return { ok: true };
});

/**
 * evaluateThresholds (scheduled)
 * - Runs daily (or hourly) to detect users who missed X consecutive days
 * - Creates nudge jobs in `nudges` collection
 */
export const evaluateThresholds = functions.pubsub
  .schedule("every 60 minutes")
  .timeZone("Asia/Kuala_Lumpur")
  .onRun(async () => {
    // TODO:
    // 1) Query users with enabled monitoring
    // 2) Compute days since last check-in
    // 3) If breached -> create nudge doc
    await admin.firestore().collection("events").add({
      type: "threshold_scan",
      ts: admin.firestore.Timestamp.now(),
    });
    return null;
  });

/**
 * sendNudge
 * - Triggered when a nudge doc is created
 * - Sends FCM push, records status
 */
export const sendNudge = functions.firestore
  .document("nudges/{nudgeId}")
  .onCreate(async (snap) => {
    const nudge = snap.data() as any;
    const uid = nudge.uid;

    // TODO: lookup user's FCM token(s) from /users/{uid}
    // TODO: send push, update nudge status
    await admin.firestore().collection("events").add({
      type: "nudge_created",
      uid,
      nudgeId: snap.id,
      ts: admin.firestore.Timestamp.now(),
    });

    return;
  });

/**
 * startPremiumEscalation (placeholder)
 * - Premium-only. Validates consent, reads premium profile, contacts emergency contact(s)
 * - For MVP, keep this as a manual workflow or partner integration.
 */
export const startPremiumEscalation = functions.https.onCall(async (_data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "Sign-in required");
  // TODO: check subscription status, consent, and execute escalation
  return { ok: false, reason: "not_implemented" };
});
