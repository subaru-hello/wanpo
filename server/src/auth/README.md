# AuthController Documentation

## Overview

The `AuthController` class in the NestJS application is responsible for handling all authentication-related operations. This includes user sign-up, verification, password management, and session validation.

## Routes

### POST /auth/sign-up

- **Description**: Registers a new user and sends a verification code to their email.
- **Body**: `SignUpRequestDto` - Contains the user's email and password.
- **Responses**:
  - **200 OK**: Successfully registered and sent a verification email.
  - **Errors**: Returns an error if the email is already in use.

### POST /auth/verify

- **Description**: Verifies a user's account using a token sent to their email.
- **Body**: `VeirfyRequestDto` - Contains the user's email and the token.
- **Responses**:
  - **Success**: User verification successful.
  - **Errors**: User not found or verification failed.

### POST /auth/login

- **Description**: Authenticates a user and returns JWT tokens.
- **Body**: `AuthenticateRequestDto` - Contains the user's email and password.
- **Responses**:
  - **200 OK**: Authentication successful, returns tokens.
  - **Errors**: Authentication failed.

### POST /auth/change-password

- **Description**: Allows a user to change their password.
- **Body**: `ChangePasswordRequestDto` - Contains email, old password, and new password.
- **Responses**:
  - **Success**: Password changed successfully.
  - **Errors**: Old password incorrect or operation failed.

### POST /auth/forgot-password

- **Description**: Initiates a password reset process by sending a verification code.
- **Body**: `ForgotPasswordRequestDto` - Contains the user's email.
- **Responses**:
  - **Success**: Verification code sent.
  - **Errors**: Email not found.

### POST /auth/reset-password

- **Description**: Resets a user's password using a verification code.
- **Body**: `ForgotPasswordRequestDto` - Contains the user's email, verification code, and new password.
- **Responses**:
  - **Success**: Password reset successfully.
  - **Errors**: Verification failed or operation failed.

### DELETE /auth/delete

- **Description**: Deletes a user from the Cognito user pool.
- **Body**: JSON object containing the user's email.
- **Responses**:
  - **Success**: User deleted successfully.
  - **Errors**: Deletion failed.

### GET /auth/is-logged-in

- **Description**: Checks if the user is currently logged in.
- **Responses**:
  - **200 OK**: Returns true if logged in, otherwise false.

### GET /auth/refresh-access-token

- **Description**: Refreshes the access token using a refresh token.
- **Responses**:
  - **200 OK**: Access token refreshed successfully.
  - **401 Unauthorized**: Login required.

## Dependencies

- `AuthService`: Service that handles the business logic for authentication.
- `DogOwnerService`: Service that manages dog owner data.
- `Response`, `Request`: Express objects for handling HTTP requests and responses.

## Utilities

- `httpUtils`: Contains utility functions like `extractValueFromCookie` for handling cookies.
- `cognito`: Contains utility functions like `fetchUsersFromCognitoPool` for interacting with AWS Cognito.

## Constants

- `COGNITO_KEY`, `REFRESH_TOKEN_KEY`: Used for managing cookie data.
- `ERROR_CODES`: Contains custom error codes used throughout the authentication processes.

## Examples

```typescript
const signUpResult = await authController.signUp({
  email: 'test@example.com',
  password: 'SecurePassword123',
});
```
