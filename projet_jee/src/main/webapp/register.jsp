<%@ page contentType="text/html;charset=UTF-8" language="java" %> <% String
error = (String) request.getAttribute("error"); String success = (String)
request.getAttribute("success"); %>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inscription - Plateforme d'échange étudiant</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        padding: 2rem 0;
      }
      .register-card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }
      .register-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 2rem;
        text-align: center;
      }
      .register-body {
        padding: 2rem;
      }
      .form-control {
        border-radius: 10px;
        border: 2px solid #e9ecef;
        padding: 12px 15px;
      }
      .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      }
      .btn-register {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        border-radius: 10px;
        padding: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      .btn-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="register-card">
            <div class="register-header">
              <i class="fas fa-user-plus fa-3x mb-3"></i>
              <h3>Inscription</h3>
              <p class="mb-0">Rejoignez la communauté étudiante</p>
            </div>
            <div class="register-body">
              <% if (error != null) { %>
              <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i><%= error %>
              </div>
              <% } %> <% if (success != null) { %>
              <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i><%= success %>
              </div>
              <% } %>

              <form action="auth/register" method="post">
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="name" class="form-label">
                      <i class="fas fa-user me-2"></i>Nom complet
                    </label>
                    <input
                      type="text"
                      class="form-control"
                      id="name"
                      name="name"
                      required
                    />
                  </div>

                  <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">
                      <i class="fas fa-envelope me-2"></i>Email
                    </label>
                    <input
                      type="email"
                      class="form-control"
                      id="email"
                      name="email"
                      required
                    />
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="password" class="form-label">
                      <i class="fas fa-lock me-2"></i>Mot de passe
                    </label>
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      name="password"
                      required
                    />
                  </div>

                  <div class="col-md-6 mb-3">
                    <label for="filiere" class="form-label">
                      <i class="fas fa-graduation-cap me-2"></i>Filière
                    </label>
                    <select
                      class="form-control"
                      id="filiere"
                      name="filiere"
                      required
                    >
                      <option value="">Sélectionnez votre filière</option>
                      <option value="Informatique">Informatique</option>
                      <option value="Génie Civil">Génie Civil</option>
                      <option value="Électrique">Électrique</option>
                      <option value="Mécanique">Mécanique</option>
                      <option value="Gestion">Gestion</option>
                      <option value="Commerce">Commerce</option>
                      <option value="Autre">Autre</option>
                    </select>
                  </div>
                </div>

                <div class="mb-4">
                  <label for="phone" class="form-label">
                    <i class="fas fa-phone me-2"></i>Téléphone (optionnel)
                  </label>
                  <input
                    type="tel"
                    class="form-control"
                    id="phone"
                    name="phone"
                    placeholder="Ex: +212 6 12 34 56 78"
                  />
                  <small class="form-text text-muted"
                    >Pour WhatsApp et contact direct</small
                  >
                </div>

                <div class="d-grid">
                  <button type="submit" class="btn btn-primary btn-register">
                    <i class="fas fa-user-plus me-2"></i>S'inscrire
                  </button>
                </div>
              </form>

              <hr class="my-4" />

              <div class="text-center">
                <p class="mb-0">Déjà un compte ?</p>
                <a href="login.jsp" class="btn btn-outline-primary mt-2">
                  <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                </a>
              </div>

              <div class="text-center mt-3">
                <a href="index.jsp" class="text-muted">
                  <i class="fas fa-arrow-left me-1"></i>Retour à l'accueil
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
