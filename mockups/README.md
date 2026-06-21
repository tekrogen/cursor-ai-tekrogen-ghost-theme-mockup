You are a Senior Product Designer, Ghost CMS Theme Architect, UX Strategist, and Design System Specialist.

Your task is to create a production-ready high-fidelity mockup for a custom Ghost Pro theme using the existing Tekrogen Brand Design System.

Based on the workflow diagram, the Publishing System specification, the BNR roadmap, and the existing Tekrogen design artifacts, the mockup should not be designed as a traditional blog theme. It should be designed as a visual representation of the Tekrogen Flywheel:

Use Case Study → Research → Demo/POC → Registration → Product → License → Download → Documentation → Versioning

The mockup's primary responsibility is helping visitors understand where they are in the flywheel and what the next logical step is. This aligns directly with the BNR's four-pillar model and publishing workflow.

This is NOT a generic blog.


Additional inputs and resources:
Tekrogen Ghost Theme Mockups: https://claude.ai/design/p/833e0a82-84e5-46f8-b26f-a8a57f308a23
Tekrogen Design System: https://claude.ai/design/p/019e1ce2-d0e9-7542-b649-e21f0ca4512e
Tekrogen Mockup Repo: https://github.com/tekrogen/Tekrogen-Ghost-Theme-Mockup
Tekrogen Design System Repo: https://github.com/tekrogen/Tekrogen-Brand-Design-System
Tekrogen New Mockup Build Path: [Create new mockups in this directory](/mockups/README.md)
Tekrogen Workflow Publishing System: `/Users/martiniquehdolce/dev/tekrogen/Tekrogen-Ghost-theme-mockup/admin/features/proposed/tekrogen-mockup-revamp/_planning-specs`

The theme must visually represent the Tekrogen Business Flywheel:

Use Case Study (.org)
→ Technical Research
→ Proof of Concept / Demo (.studio)
→ User Registration
→ Product (.com)
→ Licensing
→ Download Delivery
→ Documentation / Versioning (.net)

The resulting mockup should be intentionally designed so it can be converted directly into a Ghost Pro custom theme using Handlebars templates and Ghost routing.

────────────────────────────────────────────
DESIGN SYSTEM
────────────────────────────────────────────

Use the existing Tekrogen Design System.

Brand Personality:
- Technical
- Professional
- Research-driven
- Modern SaaS
- Developer-focused
- Premium but approachable

Typography (Tekrogen brand — sans-only, per ADR-0001 / ADR-0008):
- Poppins for headings + body (primary)
- Manrope as the sans fallback
- JetBrains Mono for technical / mono labels
(No Nunito — not a Tekrogen face. All weights self-hosted; no Google Fonts CDN.)

Visual Language:
- Clean whitespace
- Structured layouts
- Card-based content
- Architectural diagrams
- Research-first presentation

Use the Dragonfly brand architecture.

Four Pillars:

ORG      = Knowledge / Research
STUDIO   = Demonstrations / POCs
COM      = Products / Commerce
NET      = Documentation / Distribution

Each pillar must have a distinct color identity while remaining within the Tekrogen design system.

────────────────────────────────────────────
SITE ARCHITECTURE
────────────────────────────────────────────

Primary Navigation:

Home
Case Studies
Technical Research
Demos & POCs
Products
Documentation
About
Contact

Secondary Utility Navigation:

Search
Sign In
Member Dashboard
Cart
Account

────────────────────────────────────────────
HOME PAGE
────────────────────────────────────────────

Design a homepage containing:

1. Hero Section

Headline:

"We Build Real Solutions to Real Problems."

Subheadline:

Research, demonstrations, and production-ready products derived from actual implementations.

Primary CTA:
Explore Case Studies

Secondary CTA:
View Demos

Hero visualization should represent the four-pillar Tekrogen Flywheel.

────────────────────────────────────────────

2. Featured Case Studies

Card Grid

Each card contains:

- Industry
- Problem Statement
- Solution Summary
- Related Demo
- Related Product

Visual relationships between content types must be obvious.

────────────────────────────────────────────

3. Recon Hub

Display recon topics — tags *under the single **Recon** category*, NOT separate content
types. (The v0.5.0 model folded the former SaaS Evaluation + Tech Rating types into Recon;
see recon-content-model.md.)

AI
Framework Evaluations
Architecture Reviews
Technical Researches
Developer Tools

Each topic should use visual taxonomy patterns. No scores or numeric ratings.

────────────────────────────────────────────

4. Demo / POC Showcase

Display:

Demo thumbnail
Status
Technology Stack
Related Case Study
CTA:
Launch Demo

Downloads should require registration.

────────────────────────────────────────────

5. Product Marketplace Preview

Display:

Featured products

Each product includes:

- Pricing
- License Type
- Technology Stack
- Related Demo
- Related Research

CTA:
View Product

────────────────────────────────────────────

6. Documentation Hub

Display:

Guides
Tutorials
Release Notes
Version History
Installation Docs

Documentation belongs to the .net pillar.

────────────────────────────────────────────

7. Publishing Flywheel Visualization

Create a visual section showing:

Case Study
↓
Research
↓
Demo
↓
Registration
↓
Product
↓
License
↓
Download
↓
Documentation

The flywheel should be a major visual component.

────────────────────────────────────────────
CASE STUDY TEMPLATE
────────────────────────────────────────────

Create a dedicated template:

custom-use-case-study.hbs

Include:

Hero
Problem
Acceptance Criteria
Stack Decision
Tradeoffs Table
Build Summary
Lessons Learned
Outcome

Sticky sidebar:

Related Research
Related Demos
Related Products

CTA block:

Try the Demo
View Product

────────────────────────────────────────────
TECHNICAL RESEARCH TEMPLATE
────────────────────────────────────────────

Create:

custom-research.hbs   (the unified Recon reader — research + tool/framework comparison)

Display:

Framework comparisons
Tool evaluations
Architecture decisions
Pros / Cons
Decision → the chosen stack

No numeric ratings or scores (v0.5.0 Recon decision — see recon-content-model.md).
Must visually connect to related Use Case Studies and the Demo it feeds.

────────────────────────────────────────────
DEMO TEMPLATE
────────────────────────────────────────────

Create:

custom-proof-of-concept.hbs

Include:

Live Preview
Screenshots
Video
Technical Notes

Artifact Downloads

Require registration.

Display:

Related Case Study
Related Product

────────────────────────────────────────────
PRODUCT TEMPLATE
────────────────────────────────────────────

Create:

custom-product.hbs

Include:

Product Hero
Pricing
Feature Grid
Technology Stack
License Information
Screenshots
Video

Related:

Case Studies
Research
POCs

Downloads require paid membership.

────────────────────────────────────────────
MEMBERSHIP SYSTEM
────────────────────────────────────────────

Design the following flows:

Anonymous User

Can:
- Read articles
- View demos

Cannot:
- Download artifacts

Registered Member

Can:
- Download free POCs
- Save favorites
- Submit requests

Paid Member

Can:
- Purchase products
- Download releases
- Access premium documentation

Create mockups for:

Login
Registration
Membership Dashboard
Purchase Confirmation

────────────────────────────────────────────
DIGITAL PRODUCT DELIVERY
────────────────────────────────────────────

Include architecture recommendations for:

Ghost Pro
Stripe
LemonSqueezy
Gumroad

Preferred workflow:

Ghost
→ Product Page
→ LemonSqueezy Checkout
→ Payment
→ License Delivery
→ Download Access
→ Customer Portal

Design UI placeholders for:

License Selection

- MIT
- Standard
- Extended
- Team

Order History

Downloads

Version Updates

────────────────────────────────────────────
USER REQUEST SYSTEM
────────────────────────────────────────────

Create a dedicated member-only section:

Request a Demo
Request a Product
Suggest a Use Case

Fields:

Problem Description
Industry
Priority
Budget
Contact Information

Design as a professional product inquiry workflow.

────────────────────────────────────────────
GHOST IMPLEMENTATION REQUIREMENTS
────────────────────────────────────────────

The design must be directly translatable into:

home.hbs
index.hbs
post.hbs
page.hbs

custom-use-case-study.hbs
custom-research.hbs
custom-proof-of-concept.hbs
custom-product.hbs

channel-use-case-studies.hbs
channel-research.hbs
channel-pocs.hbs
channel-products.hbs
channel-documentation.hbs

partials:

navigation
hero
flywheel
product-card
study-card
demo-card
membership-gate
download-panel
related-content
footer

Avoid design concepts that require complex React applications.

Favor native Ghost patterns.

The final mockup should look like a premium SaaS product ecosystem while remaining practical to implement as a custom Ghost Pro theme.

For the mockup itself, I would organize the entire UI around the four-pillar color system defined in the Tekrogen brand, ensuring a cohesive and professional look that aligns with the brand's identity. This will help maintain brand consistency and provide a polished user experience.

| Pillar  | Purpose                      | Color Role   |
|---------|------------------------------|--------------|
| .org    | Research / Case Studies      | Primary Blue |
| .studio | Demos / POCs                 | Light Blue   |
| .com    | Products / Commerce          | Teal Accent  |
| .net    | Documentation / Distribution | Mint         |
