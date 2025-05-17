<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Submit a Support Ticket</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3f37c9;
      --accent-color: #4895ef;
      --light-color: #f8f9fa;
      --dark-color: #212529;
    }

    body {
      background-color: #f0f2f5;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .card {
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      border-radius: 15px 15px 0 0 !important;
      padding: 20px;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: var(--secondary-color);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 12px 15px;
      border: 1px solid #dee2e6;
      transition: all 0.3s;
    }

    .form-control:focus, .form-select:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 0 0.25rem rgba(72, 149, 239, 0.25);
    }

    .form-label {
      font-weight: 500;
      margin-bottom: 8px;
      color: #495057;
    }

    .category-icon {
      margin-right: 10px;
    }

    .ticket-title {
      font-size: 2rem;
      font-weight: 700;
    }

    .submit-wrapper {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .success-message {
      display: none;
      background-color: #d4edda;
      color: #155724;
      padding: 15px;
      border-radius: 8px;
      margin-top: 20px;
      text-align: center;
    }

    @media (max-width: 576px) {
      .card-header {
        padding: 15px;
      }

      .ticket-title {
        font-size: 1.5rem;
      }
    }
  </style>
</head>
<body>
<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
      <div class="card">
        <div class="card-header">
          <h1 class="ticket-title mb-0"><i class="fas fa-ticket-alt me-2"></i>Support Ticket</h1>
          <p class="text-light mb-0 mt-2">We're here to help you resolve your issues</p>
        </div>

        <div class="card-body p-4">
          <form action="SubmitTicketServlet" method="post" id="ticketForm">
            <div class="mb-4">
              <label for="category" class="form-label">Category</label>
              <select name="category" id="category" class="form-select" required>
                <option value="" disabled selected>Please select an issue category</option>
                <option value="Student Issues"><i class="fas fa-user-graduate"></i> Student Issues</option>
                <option value="Registration Issues">Registration Issues</option>
                <option value="Course Related Issues">Course Related Issues</option>
                <option value="Technical Support">Technical Support</option>
                <option value="Billing Questions">Billing Questions</option>
              </select>
            </div>

            <div class="mb-4">
              <label for="subject" class="form-label">Subject</label>
              <input type="text" name="subject" id="subject" class="form-control" placeholder="Brief description of your issue" required>
            </div>

            <div class="mb-4">
              <label for="priority" class="form-label">Priority</label>
              <select name="priority" id="priority" class="form-select">
                <option value="Low">Low</option>
                <option value="Medium" selected>Medium</option>
                <option value="High">High</option>
                <option value="Urgent">Urgent</option>
              </select>
            </div>

            <div class="mb-4">
              <label for="message" class="form-label">Message</label>
              <textarea name="message" id="message" class="form-control" rows="5" placeholder="Please describe your issue in detail..." required></textarea>
            </div>

            <div class="submit-wrapper">
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-paper-plane me-2"></i>Submit Ticket
              </button>
              <span class="text-muted">Our team typically responds within 24 hours</span>
            </div>
          </form>

          <div class="success-message mt-4" id="successMessage">
            <i class="fas fa-check-circle me-2"></i>Your ticket has been submitted successfully. We'll get back to you soon!
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('ticketForm').addEventListener('submit', function(e) {
    // In a real application, you'd submit the form normally
    // This is just for demo purposes to show the success message
    e.preventDefault();
    document.getElementById('successMessage').style.display = 'block';
    document.getElementById('ticketForm').style.display = 'none';
  });

  // Add icons to category options after DOM is loaded
  document.addEventListener('DOMContentLoaded', function() {
    const categorySelect = document.getElementById('category');
    const options = categorySelect.options;

    // Map of icons for each category
    const iconMap = {
      'Student Issues': 'fas fa-user-graduate',
      'Registration Issues': 'fas fa-clipboard-list',
      'Course Related Issues': 'fas fa-book',
      'Technical Support': 'fas fa-laptop-code',
      'Billing Questions': 'fas fa-credit-card'
    };

    // Skip the first placeholder option
    for (let i = 1; i < options.length; i++) {
      const option = options[i];
      const icon = iconMap[option.value];
      if (icon) {
        option.innerHTML = `<i class="${icon}"></i> ${option.value}`;
      }
    }
  });
</script>
</body>
</html>